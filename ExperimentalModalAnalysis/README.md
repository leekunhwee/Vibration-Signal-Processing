# Experimental Modal Analysis (Impact Testing)

* <table><tr><td>（编辑公式时，如果公式中存在下划线前有空格，那么必须统一都包含空格，否则会出现无法显示的情况。）</td></tr></table>
* <table><tr><td>（想显示 $ \lbrace \rbrace  $，得用 \lbrace \rbrace 命令）</td></tr></table>

Measured from the tool tip in axial $(z)$ direction, the approximate impact locations of the $5$ points are $0$, $55$, $90$, $130$ and $165$ mm. The vibration is measured at the tool tip (Point $1$) by an accelerometer.

<div align = "center">
<img src = "Tool.png"  width = "250" height = "200" alt = "Points on the Tool" title = "Points on the Tool">
</div>
<p align = "center"><b>Points on the Tool</b></p>

In the five .txt files, the first column of each file is the frequency $\text{[Hz]}$, second column is the real part of the computed $FRF$ $\text{[m/N]}$, and the third column is the imaginary part of the computed $FRF$ $\text{[m/N]}$.


For multi-degree freedom systems, the equation of motion in local coordinate system is given as:
$$m\ddot x + c\dot x + kx = F $$

or in matrix from:

$${[{M_x}]{\lbrace \ddot x \rbrace }  + {[{C_x}] \lbrace \dot x \rbrace}  + [ {{K_x}} ]\lbrace x \rbrace = \lbrace F \rbrace}$$

These equations are coupled and are cumbersome to solve for more than two degree of freedom systems, thus they are converted to modal coordinates as:

$$[ {{M_q}} ]\lbrace {\ddot q} \rbrace + [ {{C_q}} ]\lbrace {\dot q} \rbrace + [ {{K_q}} ]\lbrace q \rbrace = \lbrace R \rbrace$$

Where the modal mass, modal damping and model stiffness are separately:

$${[ M _q] _k} = \lbrace P \rbrace _k^T[ {{M_x}} ]{\lbrace P \rbrace _k}$$

$${[ C _q] _k} = \lbrace P \rbrace _k^T[ {{C_x}} ]{\lbrace P \rbrace _k}$$

$${[ K _q] _k} = \lbrace P \rbrace _k^T[ {{K_x}} ]{\lbrace P \rbrace _k}$$

And $\lbrace P \rbrace _k $ is the Eigenvector (mode shapes) of $k^{th}$ order with a structure like:

$$ \lbrace P \rbrace _k = \begin{pmatrix}
{p _{1}}\\\\
{p _{2}}\\\\
{p _{3}}\\\\
{\vdots }\\\\
{P _{n}}
\end{pmatrix} _k
$$

The Frequency Response Function ($FRF$) of the system can be write as:

$$ [ {H(s)} ] = \frac{{\lbrace {X(s)} \rbrace}}{{\lbrace {F(s)} \rbrace}} $$

The element in row $i$ and column $l$ of $\left[ {H\left( s \right)} \right]$ matrix may be given as residues form:

$$ {h_{il}} = \sum\limits_{k = 1}^n {\left( {\frac{{{\alpha _{il,k}} + {\beta _{il,k}}s}}{{{s^2} + 2{\xi _k}{\omega _{n,k}}s + \omega _{n,k}^2}}} \right)} $$

Where $n$ – number of modes; $\omega _{n,k}$ and $\zeta _k$ are the undamped natural frequencies and the modal damping ratio for mode $k$ of the system.

The mode shapes are found from the estimated residues. Displacement vector can be expressed by its mode shapes $\lbrace P \rbrace_k  $ and modal transfer functions $ \Phi _{q,k} $.

$$\lbrace X \rbrace = \left( {\sum\limits_{k = 1}^n {{{\lbrace P \rbrace}_k}\lbrace P \rbrace_k^T {\Phi _{qk}}} } \right)\lbrace F \rbrace$$

Thus,

$$ {[H(s)]} = {\sum\limits _{k = 1}^n {{\frac{{\lbrace P \rbrace _k} {\lbrace P  \rbrace _k^T}}{m _{q,k}}}{\frac{1}{{{s^2}+ {2{\zeta _k}{\omega _{n,k}}s} + {\omega _{n,k} ^2}}}}}} = {\sum\limits _{k = 1}^n {\frac{[R] _k}{s^2 + 2{\zeta _k}{\omega _{n,k}}s + \omega _{n,k}^2 }}} $$

Note that the modal mass for mode $k$ using the unscaled modal matrix is:

$$ {m _{q,k}} = \lbrace P \rbrace _k^T[ {{M _x}} ]{\lbrace P \rbrace _k} $$

Thus $ ({\lbrace P \rbrace _k^T{\lbrace P \rbrace _k}})/{m _{q,k}} $ represents the normalization of each eigenvector with the square root of the modal mass.

$$ {\frac{\lbrace P \rbrace _k^T}{\sqrt {m _{q,k}}}}{[M _x]}{\frac{\lbrace P _k \rbrace}{\sqrt {m _{q,k}}}} = 1 $$

$$ \lbrace u \rbrace _k^T[ {{M _x}} ]{\lbrace u \rbrace _k} = 1 $$

This is a convenient way to identify the modal parameters, i.e. mode shapes, modal stiffness and modal damping of the structure. Where ${\lbrace u \rbrace _k}$ corresponds to the normalized mode shape giving a unity modal mass, whit  a structure like:

$$ \lbrace u \rbrace _k = \begin{pmatrix}
{u _{1}}\\\\
{u _{2}}\\\\
{u _{3}}\\\\
{\vdots }\\\\
{u _{n}}
\end{pmatrix} _k
$$


$$ \frac{\lbrace P \rbrace _k \lbrace P \rbrace _k^T }{m _{ q,k}} = \lbrace u \rbrace _k \lbrace u \rbrace _k^T = [R] _k $$

Where, the residue matrix for a particular mode $k$ can be expressed in the following general form:

$$[ R ]_k = \begin{bmatrix}{u_1}{u_1} & {u_1}{u_2} & \cdots & {u_1}{u_l} & \cdots & {u_1}{u_n}\\\\
{{u_2}{u_1}} & {{u_2}{u_2}} & \cdots & {u_2}{u_l} & \cdots & {{u_2}{u_n}}\\\\
\vdots & \vdots & \ddots & \vdots & \vdots & \vdots\\\\
{{u_l}{u_1}} & {{u_l}{u_2}} & \cdots & {u_l}{u_l} & \cdots & {{u_l}{u_n}}\\\\
\vdots & \vdots & \vdots & \vdots & \ddots & \vdots\\\\
{{u_n}{u_1}} & {{u_n}{u_2}} & \cdots & {u_n}{u_l} & \cdots & {{u_n}{u_n}}\end{bmatrix}_k$$

If we take row $l$ of the residue matrix for mode $k$, we have:

$$ \begin{pmatrix}
{R_{l1}}&{R_{l2}}& \cdots &{R_{ll}}& \cdots &{R_{ln}}
\end{pmatrix}_k =
\begin{pmatrix}
{u_l}{u_1}&
{u_l}{u_2}&
& \cdots &
{u_l}{u_l}&
& \cdots &
{u_l}{u_n}
\end{pmatrix}_k $$

Where, $k=1,2,…, n$ for n number of modes. In our case, when we choose move the hammer to impact all the point on the tool-holder combination and measure the vibration at point $1$ where the accelerometer is mounted. The residue matrix for specific modes will be of the form:

$$ \begin{pmatrix}
{R_{11}}&
{R_{12}}&
{R_{13}}&
{R_{14}}&
{R_{15}}
\end{pmatrix}_k =
\begin{pmatrix}
{u_1}{u_1}&
{u_1}{u_2}&
{u_1}{u_3}&
{u_1}{u_4}&
{u_1}{u_5}
\end{pmatrix}_k $$

The transfer function ${\Phi _{11}}$is measured by hitting the structure at point $1$ and measuring at point $1$, i.e. where the accelerometer is mounted. This is known as the direct transfer function. The transfer function ${\Phi _{12}}$ is measured by hitting the structure at point $2$ and measuring at point $1$. This is a cross transfer function.

$$ \Phi  = G + jH $$

<b> Where, the $u_{11}u_{11}$ means the direct displacement response residues of point $1$ contributed by the first mode. E.g. for $u_{11}$, First subscript denote the measured (for left $u$) or impact point (for right $u$), and Second subscript denote the modal number.</b>

If let $ s \to j\omega $

$$ {\Phi _{11}} = {\left( {\frac{{{u _{11}}{u _{11}}}}{{{\omega ^2} + j2{\zeta _1}{\omega _{n1}}\omega  - \omega _{n1}^2}}} \right) _{mode\ 1}} + {\left( {\frac{{{u _{12}}{u _{12}}}}{{{\omega ^2} + j2{\zeta _2}{\omega _{n2}}\omega - \omega _{n2}^2}}} \right) _{mode\ 2}} + {\left( {\frac{{{u _{13}}{u _{13}}}}{{{\omega ^2} + j2{\zeta _3}{\omega _{n3}}\omega - \omega _{n3}^2}}} \right) _{mode\ 3}} $$

When $ω=ω_{n1}$ , leads to a negligible contribution from $ω_{n2}$ and $ω_{n3}$, and the first part approximately equal to:

$$ {\Phi _{11}}\left( {\omega  = {\omega _{n1}}} \right) \approx {\left( {\frac{{{u _{11}}{u _{11}}}}{{\omega _{n1}^2 + j2{\zeta _1}{\omega _{n1}}{\omega _{n1}} - \omega _{n1}^2}}} \right) _{mode\ 1}} $$

So we have:

$$ {\Phi _{11}}\left( {\omega  = {\omega _{n1}}} \right) \approx j{H _{11,1}} = {\left( {\frac{{{u _{11}}{u _{11}}}}{{j2{\zeta _1}\omega _{n1}^2}}} \right) _{mode\ 1}} $$

$$ {u _{11}} = \sqrt { - 2{\zeta _1}\omega _{n1}^2{H _{11,1}}} $$

Similarly, when $ω=ω_{n2}$  and $ω=ω_{n3}$,

$$ {\Phi _{11}}\left( {\omega  = {\omega _{n2}}} \right) \approx j{H _{11,2}} = {\left( {\frac{{{u _{12}}{u _{12}}}}{{j2{\zeta _2}\omega _{n2}^2}}} \right) _{mode\ 2}} $$

$$ {u _{12}} = \sqrt { - 2{\zeta _2}\omega _{n2}^2{H _{11,2}}} $$

$$ {\Phi _{11}}\left( {\omega  = {\omega _{n3}}} \right) \approx j{H _{11,3}} = {\left( {\frac{{{u _{13}}{u _{13}}}}{{j2{\zeta _3}\omega _{n3}^2}}} \right) _{mode\ 3}} $$

$$ {u _{13}} = \sqrt { - 2{\zeta _3}\omega _{n3}^2{H _{11,3}}} $$

Similarly,

$$ {\Phi _{12}} = {\left( {\frac{{{u _{11}}{u _{21}}}}{{{s^2} + 2{\zeta _1}{\omega _{n1}}s + \omega _{n1}^2}}} \right) _{mode\ 1}} + {\left( {\frac{{{u _{12}}{u _{22}}}}{{{s^2} + 2{\zeta _2}{\omega _{n2}}s + \omega _{n2}^2}}} \right) _{mode\ 2}} + {\left( {\frac{{{u _{13}}{u _{23}}}}{{{s^2} + 2{\zeta _3}{\omega _{n3}}s + \omega _{n3}^2}}} \right) _{mode\ 3}} $$

Again, substituting $ s \to j\omega $ and then $ω=ω_{n1}$, $ω=ω_{n2}$ and $ω=ω_{n3}$ subsequently, gives:

$$
\begin{array}\\
{u_{21}} = \frac{{{-2}{\zeta _1}{\omega _{n1}^2}{H _{12,1}}}}{{{u _{11}}}} & {u _{22}} = \frac{{{-2}{\zeta _2}{\omega _{n2}^2}{H _{12,2}}}}{{{u _{12}}}} & {u _{23}} = \frac{{{-2}{\zeta _3}{\omega _{n3}^2}{H _{12,3}}}}{{u _{13}}}
\end{array}
$$

Similarly,
$$
\begin{array}\\
{u_{31}} = \frac{{{-2}{\zeta _1}{\omega _{n1}^2}{H _{13,1}}}}{{{u _{11}}}} & {u _{32}} = \frac{{{-2}{\zeta _2}{\omega _{n2}^2}{H _{13,2}}}}{{{u _{12}}}} & {u _{33}} = \frac{{{-2}{\zeta _3}{\omega _{n3}^2}{H _{13,3}}}}{{u _{13}}}
\end{array}
$$

$$
\begin{array}\\
{u_{41}} = \frac{{{-2}{\zeta _1}{\omega _{n1}^2}{H _{14,1}}}}{{{u _{11}}}} & {u _{42}} = \frac{{{-2}{\zeta _2}{\omega _{n2}^2}{H _{14,2}}}}{{{u _{12}}}} & {u _{43}} = \frac{{{-2}{\zeta _3}{\omega _{n3}^2}{H _{14,3}}}}{{u _{13}}}
\end{array}
$$

$$
\begin{array}\\
{u_{51}} = \frac{{{-2}{\zeta _1}{\omega _{n1}^2}{H _{15,1}}}}{{{u _{11}}}} & {u _{52}} = \frac{{{-2}{\zeta _2}{\omega _{n2}^2}{H _{15,2}}}}{{{u _{12}}}} & {u _{53}} = \frac{{{-2}{\zeta _3}{\omega _{n3}^2}{H _{15,3}}}}{{u _{13}}}
\end{array}
$$

The real and imaginary parts of the $FRFs$ are used to identify the modal parameters. In the imaginary part of the $FRF$ - the peaks correspond to the natural frequencies $ω_{nk}$. The difference between the frequencies of local maximum $(ω_{1k})$ and minimum $(ω_{2k})$ values on the real part of the $FRF$ is used to determine the modal damping ratio as follows:

$$ {\zeta _k} = \frac{{{\omega _{2k}} - {\omega _{1k}}}}{{2{\omega _{nk}}}} $$

The negative peak value from the imaginary part $(H_k)$ of the $FRF$ is also used to find the modal stiffness value as follows:

$$ {k_k} = \frac{{ - 1}}{{2{\zeta _k}{H_k}}} $$
Having obtained the modal stiffness, the modal mass and the modal damping can also be evaluated as:

$$ {m_k} = \frac{{{k_k}}}{{\omega _{nk}^2}} $$
And

$$ {c_k} = 2{\zeta _k}\sqrt {{k_k}{m_k}} $$
The value of the measurement points are given in the table.


$$
\begin{array}{c|lcr}
φ\text{(μm/N)} & \text{R(1031)} & \text{R(1104)} & \text{I(1074)}& \text{R(1914)} & \text{R(2092)} & \text{I(1961)} & \text{R(2546)} & \text{R(2783)} & \text{I(2617)}\\\\
\hline
H_{11} & 0.4049 & -0.2891 & -0.6433 & 0.1609 & -0.0588 & -0.2138 & 0.1084 & -0.1173 & -0.2180 \\\\
H_{12} & 0.2244 & -0.2384 & -0.4380 & 0.0322 & -0.0355 & -0.0879 & 0.0009 & -0.0451 & -0.0491 \\\\
H_{13} & 0.1470 & -0.1814 & -0.3077 & -0.0108 & -0.0274 & -0.0228 & -0.0240 & 0.0014 & 0.0154 \\\\
H_{14} & 0.0994 & -0.1344 & -0.2158 & -0.0252 & -0.0016 &  0.0166 & -0.0205 &  0.0091 & 0.0300 \\\\
H_{15} & 0.0730 & -0.0947 & -0.1566 & -0.0282 & 0.0037 & 0.0266 & -0.0163 & 0.0143 & 0.0328
\end{array}
$$
<br>
Therefore, the first three modal shapes are:
$$\begin{cases}
p_1 =    [1.4111 &   0.9608 &  \ \ \  0.6749 &  \ \ \ 0.4734 & \ \ \  0.3435]^T \\\\
p_2 =    [1.7165 &   0.7057 &  \ \ \  0.1830 &  -0.1333 &  -0.2136]^T \\\\
p_3 =    [2.0023 &   0.4510 &  -0.1414 &  -0.2755 &  -0.3013]^T
\end{cases}
$$
<br>
Plot as:
<div align = "center">
<img src = "Modes1.png"  width = "600" height = "400" alt = "Modal shapes of Tool" title = "Modal shapes of Tool">
</div>
<p align = "center"><b>Modal shapes of Tool</b></p>

<div align = "center">
<img src = "Modes.png"  width = "600" height = "400" alt = "Modal shapes of Tool" title = "Modal shapes of Tool">
</div>
<p align = "center"><b>Modal shapes of Tool</b></p>
<br>
