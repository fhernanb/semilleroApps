Central Limit Theorem (CLT)
=======================

The CLT is an essential theorem in probability and statistics about the distribution of the sample mean $\bar{x}_n$ from any population with finite variance. The CLT states that sample means $\bar{x}_n$ converges to a normal distribution as the sample size $n$ grows.

Symbolically
=======================
Let $x_1, x_2, \ldots, x_n$ a random sample from a population with mean $\mu$ finite variance $\sigma^2$, the sample mean

$$\bar{x}_n= \frac{1}{n} \sum_{i=1}^{n}x_i$$

has the next distribution

$$\sqrt{n} \left( \bar{x}_n - \mu \right) / \sigma \overset{d}{\rightarrow} N(0, 1), \quad n \to \infty
$$

that is to say, that the distribution of $\bar{x}_n$ can be written as

$$
\bar{x}_n \overset{aprox}{\sim} N(\mu, \sigma^2/n)
$$

as $n$ increases.

Implications
=======================
* It guarantees a pattern of behavior of the sample means as long as the condition that $n$ is large enough is met.

* The mean of the distribution of $\bar{x}$ coincides with the mean of the population $\mu$.
	
* The variability of the distribution of $\bar{x}$ is given by $\sigma^2/n$ and decreases as $n$ increases.

* As $n$ increases, the sample means $\bar{x}$ have a normal distribution regardless of the distribution of the population from which they were obtained.

