# Quantitative-3D-structural-analysis-of-the-cellular-microstructures
This repository will collect codes accompanying the publication: Quantitative 3D structural analysis of the cellular microstructures of sea urchin spines (I): Methodology. Here we provide comprehensive quantitative description and analysis of the  natural cellular materials in 3D. It provides free, open source tools for cellular materials geometry and shape analysis. Here we use sea urchin spine structure as a representative volume. Scripts are implemented in MATLAB. Enjoy this structural analysis journey!

<img src="https://github.com/Ziling-Wu/Quantitative-3D-structural-analysis-of-the-cellular-microstructures/blob/master/Images/Fig1.png" width=300 align=center><br/>

# Demonstration
The main code is put in the folder 'Code' under this repository. For the data, please download from this shared [Google Drive folder](https://drive.google.com/drive/folders/1aF0AjVVsmUzeQXLO4210gLvbiKOcbcx0?usp=sharing) and put under folder 'Code'. The 3D redndering of the provided dataset is shown as below. 

![Image of sea urchin spine](https://github.com/Ziling-Wu/Quantitative-3D-structural-analysis-of-the-cellular-microstructures/blob/master/Images/binary.png)

In the first part 01_main_dataprocessing.m, network registration is performed based on binarized 3D volume; In the second part 02_main_dataAnalysis.m, multi-scale feature extraction and data visulization are performed based on the registered network, including<br/>
1 . node configuration, branch length, thicknes, orientation, inter-branch angles in the node and branch level; <br/>
2. chain and ring analysis in the local cellular level; <br/>
3. node analysis based on Fourier transform in the global network level;<br/>
4. and correlations among different levels. <br/>
Here shows the main parametrers.<br/>
![Image of sea urchin spine](https://github.com/Ziling-Wu/Quantitative-3D-structural-analysis-of-the-cellular-microstructures/blob/master/Images/Fig7.png)
For more analysis results, please refer to our paper.

# Requirement
* MATLAB

If you found this library/demonstration useful for your research, please consider citing this work.
