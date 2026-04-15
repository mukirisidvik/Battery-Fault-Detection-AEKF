# Model-Based Sensor Fault Detection and Isolation in Lithium-Ion Battery Packs Using AEKF and Enhanced CUSUM Strategy

<div align="center">

![MATLAB](https://img.shields.io/badge/MATLAB-R2023a-orange?style=for-the-badge&logo=mathworks)
![Simulink](https://img.shields.io/badge/Simulink-R2023a-blue?style=for-the-badge&logo=mathworks)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Conference](https://img.shields.io/badge/IGEMC_2026-Paper_ID_124-red?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Accepted-brightgreen?style=for-the-badge)

**Accepted at IGEMC 2026 — Paper ID: 124**

*PV Research Lab, IIITDM Kancheepuram, Chennai*

</div>

---

## 👤 Author

| Name | Roll No | Institute |
|------|---------|-----------|
| **M. Sai Sidvik** | EC22B1009 | IIITDM Kancheepuram |

**Guide:** Dr. B. Chitti Babu, Assistant Professor, ECE Department  
**Co-Guide:** Dasari Venkayya, Research Scholar, PV Research Lab

---

## 📌 Abstract

Accurate current and voltage sensing is critical for the Battery Management System (BMS) in electric vehicles. Sensor faults can cause incorrect state estimation and unsafe operating conditions. This work presents a model-based sensor fault detection and isolation framework using an Adaptive Extended Kalman Filter (AEKF) combined with a Cumulative Sum (CUSUM) statistical test.

A five-cell series lithium-ion battery pack is modelled using a second-order RC equivalent circuit, and the AEKF estimates the terminal voltage of each cell under the Urban Dynamometer Driving Schedule (UDDS). The residual between measured and estimated voltage is evaluated using a statistical test to identify voltage and current sensor faults.

To address the detection delay limitation of standard CUSUM, an enhanced strategy is proposed that monitors the growth rate of the CUSUM statistic using a dual-threshold logic. This enables early fault prediction before the threshold is crossed. The proposed method demonstrates reduced detection latency and improved robustness compared to the standard single-threshold strategy.

---

## 🔬 Key Contributions

- ✅ Second-order RC equivalent circuit model for five-cell LiFePO4 battery pack
- ✅ AEKF-based state estimation with adaptive noise covariance updating
- ✅ Residual generation by comparing measured vs estimated terminal voltage
- ✅ Standard CUSUM fault detection for voltage and current sensor faults
- ✅ **Enhanced CUSUM** — monitors CUSUM growth rate for early fault prediction
- ✅ Dual-threshold logic (ε_low and ε_high) to classify healthy, degrading, and faulty conditions
- ✅ False alarm protection using switch logic during healthy operation
- ✅ Validated in MATLAB/Simulink under UDDS driving cycle

---

## 🏗️ System Architecture

<img width="1280" height="720" alt="block digaram" src="https://github.com/user-attachments/assets/2a548e4c-5546-4180-8c6a-42aefb6bccfc" />


<img width="835" height="648" alt="block digaram_1" src="https://github.com/user-attachments/assets/05a2260c-f032-453c-b42f-00a6f59d1bcf" />


## ⚙️ Battery Model Parameters

Five LiFePO4 cells connected in series. Parameters taken from reference literature [1].

| Cell | R (mΩ) | R₁ (mΩ) | C₁ (F) | R₂ (mΩ) | C₂ (F) |
|------|--------|---------|--------|---------|--------|
| Cell 01 | 4.3 | 0.32 | 629.7 | 2.8 | 2247.7 |
| Cell 02 | 4.5 | 0.31 | 632.4 | 3.1 | 2367.5 |
| Cell 03 | 4.2 | 0.34 | 605.3 | 3.0 | 2453.6 |
| Cell 04 | 4.1 | 0.36 | 591.5 | 2.8 | 2087.1 |
| Cell 05 | 4.1 | 0.36 | 647.1 | 3.4 | 2579.9 |

---

## 🧮 Key Equations

### Second-Order RC Model
```
Terminal Voltage:   Ut(k) = spline(SoC(k)) - U1(k) - U2(k) - R·I(k)
SoC Update:         SoC(k+1) = SoC(k) - η·Δt·I(k) / Cbat
State Vector:       xk = [U1(k)  U2(k)  SoC(k)]ᵀ
```

### AEKF Algorithm
```
Prediction:   x̂k|k-1 = f(x̂k-1, uk)
              Pk|k-1 = Ak·Pk-1·AkT + Qk

Correction:   Kk = Pk|k-1·CkT·(Ck·Pk|k-1·CkT + Vk)⁻¹
              x̂k = x̂k|k-1 + Kk·(yk - g(x̂k|k-1, uk))

Adaptive:     F̂k = (1/N) Σ μj·μjT
              Qk = Kk·F̂k·KkT
              Vk = F̂k + Ck·Pk·CkT
```

### Residual Generation
```
r(k) = y_measured(k) - y_estimated(k)
```

### Standard CUSUM
```
S(k) = max(0, S(k-1) + r(k) - ν)
Fault = 1  if  S(k) > J
Fault = 0  if  S(k) ≤ J
```

### Enhanced CUSUM (Our Contribution)
```
Step 1 — Growth Rate:    ΔS(k) = S(k) - S(k-1)
Step 2 — Smooth:         ΔSsmooth = (1/M) Σ ΔS(j)
Step 3 — Early Warning:  pred_active = 1  if  ΔSsmooth > ε_low
Step 4 — Guard:          pred_active = 0  if  ΔSsmooth ≤ ε_low
```

---

## 📊 Simulation Setup
<img width="1230" height="606" alt="setup" src="https://github.com/user-attachments/assets/b47a3075-f37b-4104-b50b-4f0a4d40a8ac" />

| Parameter | Value |
|-----------|-------|
| Simulation duration | 3000 s |
| Driving cycle | UDDS (Urban Dynamometer Driving Schedule) |
| Current range | −5 A to +5 A |
| Initial SoC | 90% |
| AEKF window size N | 100 |
| Alarm threshold J | 3000 |
| Initial error covariance P₀ | 0.01 · I |

---

## 📈 Results
**Voltage response of all cells under UDDS cuurent input**
<img width="1393" height="713" alt="Cells voltages and zoomed plot_8" src="https://github.com/user-attachments/assets/193601a9-e119-4a12-aaa8-ee865da1f6ea" />

### Voltage Sensor Fault (0.02 V bias at t = 1000 s)

| | Standard CUSUM | Enhanced CUSUM |
|--|--|--|
| Fault injection | t = 1000 s | t = 1000 s |
| Detection time | t = 1018 s | t = 1005 s |
| Detection delay | 18 s | 5 s |
| **Improvement** | — | **13 s earlier** |

**Residual Signal — Voltage Fault**

<img width="1329" height="727" alt="volatge fault residual r U max_1_188" src="https://github.com/user-attachments/assets/83686889-8ab2-49a9-9470-63ffd5293195" />


**CUSUM Evaluation — Voltage Fault**

<img width="3292" height="2006" alt="Sk min_11999999" src="https://github.com/user-attachments/assets/268b4ec2-4320-4f1d-8f6c-35f470e4ac33" />


**Standard vs Enhanced Comparison — Voltage Fault**

<img width="1255" height="715" alt="voltage cusum vs ench_188" src="https://github.com/user-attachments/assets/014d7524-4c2a-4ea2-867a-c2c2d3e31f25" />


---

### Current Sensor Fault (20% scaling at t = 1500 s)

| | Standard CUSUM | Enhanced CUSUM |
|--|--|--|
| Fault injection | t = 1500 s | t = 1500 s |
| Detection time | t = 1600 s | t = 1520 s |
| Detection delay | 100 s | 20 s |
| **Improvement** | — | **80 s earlier** |

**Residual Signal — Current Fault**

<img width="1304" height="721" alt="volatge fault residual r U max_188" src="https://github.com/user-attachments/assets/5989451b-b929-4f3c-9db6-83769476aebb" />


**Standard CUSUM Detection — Current Fault**

<img width="3286" height="1981" alt="untitled99911" src="https://github.com/user-attachments/assets/8881b9f0-3c7b-4e91-a327-b124485cd9d5" />


**Standard vs Enhanced Comparison — Current Fault**

<img width="1254" height="713" alt="untitled8" src="https://github.com/user-attachments/assets/61d96a38-4d11-456b-afbb-6ed46249cc00" />


---

## 🔁 How to Run

### Requirements
- MATLAB R2020a or later
- Simulink
- Control System Toolbox

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/yourusername/battery-fault-detection-aekf-cusum.git
cd battery-fault-detection-aekf-cusum
```

**2. Open MATLAB and set path**
```matlab
addpath(genpath('matlab'))
addpath(genpath('simulink'))
```

**3. Load battery parameters**
```matlab
run('matlab/battery_parameters.m')
```

**4. Open and run the Simulink model**
```matlab
open('simulink/main_fault_detection.slx')
sim('main_fault_detection')
```

**5. Plot results**
```matlab
run('matlab/plot_results.m')
```

---

## 📋 Fault Scenarios Tested

| Fault Type | Fault Value | Injection Time |
|-----------|------------|---------------|
| Voltage sensor bias | 0.02 V | t = 1000 s |
| Current sensor scaling | 20% | t = 1500 s |

---

## 📊 Performance Comparison

| Feature | Standard CUSUM | Enhanced CUSUM |
|---------|--------------|----------------|
| Fault Detection | ✅ Yes | ✅ Yes |
| Early Warning | ❌ No | ✅ Yes |
| Degradation Awareness | ❌ No | ✅ Yes |
| Voltage Fault Latency | 18 s | 5 s |
| Current Fault Latency | 100 s | 20 s |
| False Alarms | None | None |
| Extra Hardware | Not needed | Not needed |
| Practical Relevance | Medium | High |

---

## 📄 Publication

```bibtex
@inproceedings{sidvik2026battery,
  title     = {Model-Based Sensor Fault Detection and Isolation in 
               Lithium-Ion Battery Packs Using AEKF and Enhanced CUSUM Strategy},
  author    = {Sidvik, M. Sai and Babu, B. Chitti and Venkayya, Dasari},
  booktitle = {Proceedings of the International Green Energy Mobility 
               Conference (IGEMC 2026)},
  year      = {2026},
  month     = {April},
  address   = {SRMIST, Chennai, India},
  note      = {Paper ID: 124}
}
```

---

## 📚 References

[1] Z. Liu and H. He, "Sensor fault detection and isolation for a lithium-ion battery pack in electric vehicles using adaptive extended Kalman filter," *Applied Energy*, vol. 185, pp. 2033–2044, 2017.

[2] G. L. Plett, "Extended Kalman filtering for battery management systems of LiPB-based HEV battery packs — Part 3: State and parameter estimation," *Journal of Power Sources*, vol. 134, no. 2, pp. 277–292, 2004.

[3] Z. Zhang, L. Jiang, L. Zhang, and C. Huang, "State-of-charge estimation of lithium-ion battery pack by using an adaptive extended Kalman filter for electric vehicles," *Journal of Energy Storage*, vol. 37, p. 102457, 2021.

[4] R. Isermann, "Model-based fault-detection and diagnosis — status and applications," *Annual Reviews in Control*, vol. 29, no. 1, pp. 71–85, 2005.

[5] S. Zhang, S. Jiang, H. Wang, and X. Zhang, "A novel dual time-scale voltage sensor fault detection and isolation method for series-connected lithium-ion battery pack," *Applied Energy*, vol. 322, 2022.

---

## 📬 Contact

**M. Sai Sidvik**  
B.Tech ECE, IIITDM Kancheepuram  
📧 ec22b1009@iiitdm.ac.in

---

<div align="center">

*PV Research Lab — IIITDM Kancheepuram*  
*Department of Electronics and Communication Engineering*

</div>
