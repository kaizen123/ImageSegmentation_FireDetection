from __future__ import print_function

import math
import sklearn
from skimage import color
from skimage.measure._structural_similarity import compare_ssim as ssim
import cv2
import matplotlib.image as mpimg
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial.distance import cdist
from sklearn.metrics import silhouette_samples, silhouette_score
from sklearn.cluster import KMeans


def kmeans_init_centers(X, K):
    return X[np.random.choice(X.shape[0], K, replace=False)]


def kmeans_assign_labels(X, centers):
    D = cdist(X, centers)
    return np.argmin(D, axis=1)


def kmeans_update_centers(X, labels, K):
    centers = np.zeros((K, X.shape[1]))
    for k in range(K):
        Xk = X[labels == k, :]
        centers[k, :] = np.mean(Xk, axis=0)
    return centers


def kmeans_converged(centers, new_centers):
    return (set([tuple(a) for a in centers]) ==
            set([tuple(a) for a in new_centers]))


def kmeans(X, K):
    centers = [kmeans_init_centers(X, K)]
    labels = []
    it = 0
    while True:
        labels.append(kmeans_assign_labels(X, centers[-1]))
        new_centers = kmeans_update_centers(X, labels[-1], K)
        if kmeans_converged(centers[-1], new_centers):
            break
        centers.append(new_centers)
        it += 1
    return centers, labels, it


def mse(imageA, outImg):
    err = np.sum((imageA.astype("float") - outImg.astype("float")) ** 2)
    err /= float(imageA.shape[0] * imageA.shape[1] * imageA.shape[2])
    return err


def mae(imageA, outImg):
    err = np.sum(np.abs(imageA.astype("float") - outImg.astype("float")))
    err /= float(imageA.shape[0] * imageA.shape[1] * imageA.shape[2])
    return err


def snr(inImg, outImg):
    err = np.sum((inImg.astype("float")) ** 2)
    temp = np.sum((inImg.astype("float") - outImg.astype("float")) ** 2)
    if temp == 0:
        return 100
    return err / temp


def psnr(inImg, outImg):
    MSE = mse(inImg, outImg)
    if MSE == 0:
        return 100
    return 10 * math.log10(255 ** 2 / MSE)


def findOptimalK(k):
    wcss = list()
    silhouette = list()
    rangeK = range(2, k + 5)
    for k in rangeK:
        kmeans = KMeans(n_clusters=k)
        cluster_labels = kmeans.fit_predict(X)
        kmeans = kmeans.fit(X)
        error = kmeans.inertia_
        silhouette_avg = silhouette_score(X, cluster_labels)
        wcss.append(error)
        silhouette.append(silhouette_avg)
        print("For n_clusters =", k,
              "The average silhouette_score is :", silhouette_avg,
              "The error is :", error)

    fig, ax1 = plt.subplots()

    ax1.set_xlabel('K')
    ax1.set_ylabel('within-cluster sum of errors', color='tab:green')
    ax1.plot(rangeK, wcss, 'g*-')
    ax1.plot(k, wcss[k - 2], 'r*')
    ax1.tick_params(axis='y', labelcolor='tab:green')
    plt.title('Method For Optimal K')

    ax2 = ax1.twinx()
    ax2.set_ylabel('average silhouette', color='tab:blue')
    ax2.plot(rangeK, silhouette, 'bo-')
    ax2.plot(k, silhouette[k - 2], 'ro-')
    ax2.tick_params(axis='y', labelcolor='tab:blue')

    plt.xticks(rangeK)
    fig.tight_layout()
    plt.show()


if __name__ == '__main__':

    inImg = mpimg.imread('inImg1.jpg')
    inImg = color.rgb2lab(inImg)
    X = inImg.reshape((inImg.shape[0] * inImg.shape[1], inImg.shape[2]))

    # Y = outImg.reshape((outImg.shape[0] * outImg.shape[1], outImg.shape[2]))
    print("inImg", inImg.shape)
    print("X", X.shape)
    X = X[:, 0:3]

    inImg = X.reshape(inImg.shape[0], inImg.shape[1], 3)
    # outImg = Y.reshape(outImg.shape[0], outImg.shape[1], 3)
    K = 4
    # findOptimalK(K)

    (centers, labels, it) = kmeans(X, K)
    print(it)
    k1 = labels
    tmpImg = np.zeros_like(X)
    for k in range(K):
        tmpImg[labels[-1] == k] = centers[-1][k]

    outImg = tmpImg[:, 0:3].reshape((inImg.shape[0], inImg.shape[1], 3))
    # outImg = color.lab2rgb(outImg)
    print("outImg", outImg.shape)

    inImg = color.lab2rgb(inImg)
    outImg = color.lab2rgb(outImg)

    SSIM = ssim(inImg, outImg, multichannel=True)
    # Mean Square Error
    MSE = mse(inImg, outImg)
    # RMSE
    RMSE = math.sqrt(MSE)
    # Maximum Absolute Error
    MAE = mae(inImg, outImg)
    # Peak Signal to Noise Ratio
    PSNR = psnr(inImg, outImg)
    # SNR
    SNR = snr(inImg, outImg)

    print("MSE : ", MSE)
    print("RMSE : ", RMSE)
    print("MAE : ", MAE)
    print("PSNR : ", PSNR)
    print("SNR : ", SNR)
    print("SSIM : ", SSIM)
    print(inImg)
    print(outImg)
    outImg = color.rgb2gray(outImg)
    plt.imsave('out1.jpg', outImg)
    plt.imshow(outImg, interpolation='nearest')
    plt.show()
