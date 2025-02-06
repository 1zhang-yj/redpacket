# 微信红包金额分配模拟研究 / WeChat Red Packet Allocation Simulation Research

## 写在最前面 / Foreword
本项目所有代码均存储在`main.m`中，需要使用MATLAB运行。  
**All code for this project is stored in `main.m` and requires MATLAB to run.**

各位可以自行下载运行探究，下文仅为根据运行结果猜测的结论。  
**You may download and run the code to explore. The following conclusions are based on observed experimental results.**

---

## 核心结论 / Key Findings

### 结论1 / Conclusion 1  
**抢到金额的期望与第几个抢无关，均为红包均值**  
**The expected value of the allocated amount is independent of the grabbing order and equals the mean value of the red packet.**

### 结论2 / Conclusion 2  
**越后抢的人越容易获得"手气最佳"，也更可能获得低于均值的金额（约最后15个红包生效）**  
**Later grabbers have higher probabilities of becoming the "luckiest" and receiving amounts below the mean (observed in the last ~15 packets).**

---

## 实验分析 / Experimental Analysis

### P1-P5：千人红包大作战 / P1-P5: 1000-User Red Packet Campaign
1. **P1**  
   - 金额与抢包顺序呈白噪音序列，验证结论1  
   - **Amounts vs. grabbing order form a white noise sequence, validating Conclusion 1**

2. **P2（P1升序整理）**  
   - 金额分布以均值为中心对称，偏离越远概率越小  
   - **Sorted data shows symmetric distribution around the mean with decreasing probabilities for extreme values**

3. **P3（方差归一化分析）**  
   - 最后15组稳定性断崖式下降（稳定性系数 = 期望²/(期望²+方差)）  
   - **Normalized variance analysis reveals a cliff-like stability drop in the last 15 groups (Stability Coefficient = E²/(E² + Var))**

4. **P4（20%偏差区间）**  
   - 偏差≤20%的概率与抢包顺序无关  
   - **Probability of ≤20% deviation is order-independent**

5. **P5（80%偏差区间）**  
   - 后抢者偏差率显著升高（蓝圈: ≤180%概率，红圈: ≥20%概率）  
   - **Later grabbers show higher deviation rates (Blue: ≤180%, Red: ≥20%)**

---

### P6-P7：结论验证 / P6-P7: Validation
#### 5人抢500元红包 / 5-User 500 CNY Red Packet
- **P6**: 稳定性随抢包顺序逐渐下降  
  **Stability gradually decreases with grabbing order**
- **P7**: ±80%偏差区间概率减小，结论得证  
  **Reduced probabilities in ±80% deviation range validate conclusions**

---

## 运行建议 / Usage Notes
1. 多次运行可复现稳定性模式（非随机现象）  
   **Multiple runs reproduce stability patterns (non-random)**
2. 代码支持自定义参数：`总金额`、`人数`、`模拟次数`  
   **Customizable parameters: `Total Amount`, `Number of Users`, `Simulation Runs`**
