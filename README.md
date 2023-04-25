# Fuzzy weighted K-Nearest Neighbors Density Peak Clustering 

## Requirement

The source code is written by Matlab r2018b. Versions lower than it have not been tested.

Some functions like `squareform()` and `pdist()` require "Statistics and Machine Learning Toolbox" product.

## Demo
All modification should only be made in `fknn_dpc.m`.

### Basic Parameters

For FKNN-DPC, the parameter (`k`) is assigned at the line 19.

### Dataset

If you want to change the Dataset, please change the file address in line 3 and 4, `data` is the experimental data and 

`label` is the data class label.

### Result
The experimental results are evaluated in terms of  benchmark metrics including clustering accuracy (Acc), 

adjusted mutual information (AMI) and adjusted rand index (ARI).They are saved in `result`.

## Cite

If you use our code for your study, please cite the following papers:

[1] Juanying Xie, Hongchao Gao, Weixin Xie, Xiaohui Liu, Philip W. Grant. Robust clustering by detecting density peaks and assigning points based on fuzzy weighted K-nearest neighbors. Information Sciences,2016, 354: 19-40.

[2] Juanying Xie, Hongchao Gao, Weixin Xie. K-nearest neighbors optimized clustering algorithm by fast search and finding the density peaks of a dataset.Scientia Sinica Informationis,2016, 46(2): 258-280.

## Issues, Questions, etc

Please report issues here on the github page or contact "xiejuany@snnu.edu.cn"
