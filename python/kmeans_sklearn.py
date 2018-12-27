from __future__ import division
import cv2
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image
from scipy.misc import comb
from skimage import io, color
from sklearn.cluster import KMeans
from skimage.measure._structural_similarity import compare_ssim as ssim
from sklearn.metrics import silhouette_samples, silhouette_score


# Compute confusion matrix
def confusion_matrix(act_labels, pred_labels):
    uniqueLabels = list(set(act_labels))
    clusters = list(set(pred_labels))
    cm = [[0 for i in range(len(clusters))] for i in range(len(uniqueLabels))]
    for i, act_label in enumerate(uniqueLabels):
        for j, pred_label in enumerate(pred_labels):
            if act_labels[j] == act_label:
                cm[i][pred_label] = cm[i][pred_label] + 1
    return cm


# Accuracy, F-score, TPR, FPR
def rand_index_score(clusters, classes):
    tp_plus_fp = comb(np.bincount(clusters), 2).sum()
    tp_plus_fn = comb(np.bincount(classes), 2).sum()
    A = np.c_[(clusters, classes)]
    tp = sum(comb(np.bincount(A[A[:, 0] == i, 1]), 2).sum()
             for i in set(clusters))
    fp = tp_plus_fp - tp
    fn = tp_plus_fn - tp
    tn = comb(len(A), 2) - tp - fp - fn
    print 'TP = ', tp
    print 'FP = ', fp
    print 'FN = ', fn
    print 'TN = ', tn

    # TP rate = TP / TP+FN
    tpr = float(tp) / (tp + fn)
    # FP rate = FP / (FP + TN)
    fpr = float(fp) / (fp + tn)
    # F-score as 2TP /(2TP + FP + FN)
    fscore = float(2 * tp) / ((2 * tp) + fp + fn)
    # Accuracy Rand index score = (TP + TN) / (TP + FP + FN + TN)
    ri = (tp + tn) / (tp + fp + fn + tn)
    return [tpr, fpr, fscore, ri]


def get_tp_fp_tn_fn(cooccurrence_matrix):
    tp_plus_fp = vComb(cooccurrence_matrix.sum(0, dtype=int), 2).sum()
    tp_plus_fn = vComb(cooccurrence_matrix.sum(1, dtype=int), 2).sum()
    tp = vComb(cooccurrence_matrix.astype(int), 2).sum()
    fp = tp_plus_fp - tp
    fn = tp_plus_fn - tp
    tn = comb(cooccurrence_matrix.sum(), 2) - tp - fp - fn

    return [tp, fp, tn, fn]


def mse(imageA, outImg):
    err = np.sum((imageA.astype("float") - outImg.astype("float")) ** 2)
    err /= float(imageA.shape[0] * imageA.shape[1])
    return err


def mae(imageA, outImg):
    err = np.sum(np.abs(imageA.astype("float") - outImg.astype("float")))
    err /= float(imageA.shape[0] * imageA.shape[1])
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
    return 10 * np.math.log10(255 ** 2 / MSE)


def myComb(a, b):
    return comb(a, b, exact=True)


vComb = np.vectorize(myComb)


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


if __name__ == "__main__":
    # http://nlp.stanford.edu/IR-book/html/htmledition/evaluation-of-clustering-1.html

    # inImg = mpimg.imread('3096.jpg')
    inImg = Image.open('origin.jpg').convert('L')
    inImg = np.asarray(inImg)
    truth = Image.open('truth.png').convert('L')
    truth = np.asarray(truth)
    truth = cv2.resize(truth, (inImg.shape[1], inImg.shape[0]))
    plt.imshow(truth)
    # plt.imsave('truth_color', truth)
    # cv2.imwrite('truth.jpg', truth)

    X = inImg.reshape(inImg.shape[0] * inImg.shape[1], 1)
    # X = inImg.reshape(inImg.shape[0] * inImg.shape[1], 3)

    K = 3
    # findOptimalK(K)
    kmeans = KMeans(n_clusters=K).fit(X)
    label_pred = kmeans.predict(X)

    tmpImg = np.zeros_like(X)
    # replace each pixel by its center
    for k in range(K):
        tmpImg[label_pred == k] = kmeans.cluster_centers_[k]

    # reshape and display output image
    # outImg = tmpImg.reshape(inImg.shape[0], inImg.shape[1], 3)
    outImg = tmpImg.reshape(inImg.shape[0], inImg.shape[1])
    outImg = Image.fromarray(outImg).convert('L')

    outImg = np.asarray(outImg)

    Y = truth.reshape(inImg.shape[0] * inImg.shape[1], 1)
    kmeans1 = KMeans(n_clusters=K).fit(Y)
    label_truth = kmeans1.predict(Y)

    SSIM = ssim(truth, outImg, multichannel=True)
    truth = truth / 255
    outImg = outImg / 255
    # Mean Square Error
    MSE = mse(truth, outImg)
    # RMSE
    RMSE = np.math.sqrt(MSE)
    # Maximum Absolute Error
    MAE = mae(truth, outImg)
    # Peak Signal to Noise Ratio
    PSNR = psnr(truth, outImg)
    # SNR
    SNR = snr(truth, outImg)

    print("MSE : ", MSE)
    print("RMSE : ", RMSE)
    print("MAE : ", MAE)
    print("PSNR : ", PSNR)
    print("SNR : ", SNR)
    print("SSIM : ", SSIM)
    [tpr, fpr, fscore, ri] = rand_index_score(label_pred, label_truth)
    print "TPR: %f, FPR: %f, F1: %f, Ri: %f" % (tpr, fpr, fscore, ri)

    cnf_matrix = confusion_matrix(label_truth, label_pred)
    sum_ = np.sum(cnf_matrix)
    tp, fp, tn, fn = get_tp_fp_tn_fn(np.asarray(cnf_matrix))
    print "TP: %d, FP: %d, TN: %d, FN: %d" % (tp, fp, tn, fn)

    # Print the measures:
    print "Rand index: %f" % (float(tp + tn) / (tp + fp + fn + tn))

    precision = float(tp) / (tp + fp)
    recall = float(tp) / (tp + fn)

    print "Precision : %f" % precision
    print "Recall    : %f" % recall
    print "F1        : %f" % ((2.0 * precision * recall) / (precision + recall))
    print "tpr       : %f" % recall
    print "fnr       : %f" % (float(fn) / (tp + fn))
    print "fpr       : %f" % (float(fp) / (fp + tn))
    print "tnr       : %f" % (float(tn) / (fp + tn))
    plt.show()
