# Repository 6 — Acemoglu & Restrepo (2018)

**Paper:** Daron Acemoglu and Pascual Restrepo, *The Race between Man and Machine: Implications of Technology for Growth, Factor Shares, and Employment*.

**Version read:** NBER Working Paper 22252, revised June 2017, 87 pages.

Repository: https://github.com/carlosgomezp28/ai-06-restrepo

## Research question

How does technological change affect output, wages, employment, and factor shares when technology changes not only factor productivity but also which tasks are performed by capital and which are performed by labor?

The paper's central distinction is between:

- **automation**, which expands the set of existing tasks that capital can perform and creates a displacement effect on labor; and
- **new tasks**, which create activities in which labor has comparative advantage and generate a reinstatement effect.

Unlike the previous papers in the course, the relevant unit of analysis is the aggregate economy rather than an individual human or AI agent.

## Economic problem and task allocation

Final output combines a unit measure of tasks indexed by

```math
i\in[N-1,N].
```

Labor productivity in task $i$ is $\gamma(i)$. Assumption 1 requires $\gamma(i)$ to be strictly increasing, so labor has comparative advantage in higher-index tasks.

The automation technology is summarized by $I\in[N-1,N]$. Tasks with

```math
i\le I
```

can technologically be produced by either capital or labor, whereas tasks with $i>I$ must be produced by labor.

Competitive firms compare the rental rate of capital $R$ with the effective labor cost $W/\gamma(i)$. Define the cost threshold $\tilde I$ by

```math
\frac{W}{R}=\gamma(\tilde I).
```

The equilibrium automation threshold is therefore

```math
I^{\ast}=\min\{I,\tilde I\}.
```

Hence capital performs all tasks $i\le I^{\ast}$, while labor performs all tasks $i>I^{\ast}$.

The static analysis also imposes:

1. **Assumption 1:** $\gamma(i)$ is strictly increasing.
2. **Assumption 2:** either $\eta\to0$ or $\zeta=1$, which gives homothetic factor demands in the baseline exposition.
3. **Assumption 3:** $K<\bar K$, where $\bar K$ is defined by $R=W/\gamma(N)$. This implies $R>W/\gamma(N)$, so newly created tasks raise output and are immediately adopted.

Under Assumptions 1–3, the static equilibrium exists and is unique.

## Automation versus new tasks

When the economy is **technology constrained**,

```math
I^{\ast}=I<\tilde I,
```

an increase in $I$ expands the range of tasks performed by capital. Proposition 2 implies

```math
\frac{d\ln(W/R)}{dI}
=
-\frac{\Lambda_I}{\hat\sigma+\varepsilon_L}
<0.
```

Thus automation reduces the wage-rental ratio. In this regime it also reduces the labor share and employment.

By contrast, an increase in $N$, which represents the creation of new labor-intensive tasks, raises $W/R$, the labor share, and employment.

If instead

```math
I^{\ast}=\tilde I<I,
```

firms are not constrained by the available automation technology. Marginal increases in $I$ then have no effect on equilibrium factor prices because the additional technically automatable tasks would not yet be cost-minimizing to automate.

## Main result: automation does not necessarily reduce wages

Proposition 3 assumes Assumptions 1–3.

In the technology-constrained regime $I^{\ast}=I<\tilde I$, automation raises productivity because capital replaces labor in tasks where capital is cheaper. But it simultaneously displaces labor into a smaller set of remaining tasks.

The wage change can be decomposed as

```math
d\ln W
=
d\ln Y\big|_{K,L}
+
(1-s_L)
\left(
\frac{\Lambda_N\,dN-\Lambda_I\,dI}
{\hat\sigma+\varepsilon_L}
\right).
```

For an automation shock alone, $dI>0$ and $dN=0$:

- $d\ln Y|_{K,L}>0$: the **productivity effect** raises labor demand in tasks not automated;
- the term involving $-\Lambda_I dI$ is the **displacement effect**, which pushes wages down because workers are concentrated into fewer tasks.

Therefore automation does **not** necessarily reduce the equilibrium wage.

There exists a finite threshold $\tilde K$ such that

```math
K>\tilde K
\quad\Longrightarrow\quad
\frac{dW}{dI}>0,
```

while

```math
K<\tilde K
\quad\Longrightarrow\quad
\frac{dW}{dI}<0.
```

When capital is sufficiently abundant, the productivity gains from substituting cheaper capital for labor dominate the displacement effect. When capital is sufficiently scarce, the cost saving from automation is small and displacement dominates.

Importantly, even when automation raises the wage, in the technology-constrained regime it still reduces $W/R$, the labor share, and employment. A higher wage is therefore not equivalent to labor receiving a larger share of aggregate income.

## Displacement and reinstatement

The paper's broader mechanism is a race between two types of technological change:

- **Displacement:** automation moves tasks from labor to capital.
- **Reinstatement:** the creation of new tasks moves the frontier of production toward activities in which labor has comparative advantage.

New tasks increase productivity and, under Assumption 3, always increase the equilibrium wage. They also raise the labor share and employment, counteracting the displacement generated by automation.

## Lean formalization

The AppliedModelingLib run uses the NBER Working Paper 22252 version revised in June 2017 and the paper folder `AR18RaceManMachine`.

The final required command

`python3 scripts/paper_contribution.py check AR18RaceManMachine --fast`

completed successfully:

`Build completed successfully (832 jobs).`

`exit_code=0`

The formalization captures selected static comparative-statics quantities, the productivity/displacement wage decomposition, balanced-growth crossing conditions, and welfare decompositions. It does not reconstruct the entire continuum task economy or all of the paper's dynamic differential system; those analytic bridges remain explicit formalization boundaries documented in `lean/`.
