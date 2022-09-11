# GSoC 2022 Retrospective


# GSoC 2022 Retrospective

During the summer of 2022, I participated in the GSoC (Google Summer of Code). I was fortunate enough to be mentored by [Kevin P. Murphy](https://www.cs.ubc.ca/~murphyk/) and [Scott Linderman](https://web.stanford.edu/~swl1/). My main contributions have been for the [``probml/ssm-jax``](https://github.com/probml/ssm-jax) and [``probml/pyprobml``](https://github.com/probml/pyprobml) repos.


### Main Contributions

The majority of my time has been spent building the inference portion of the `ssm-jax` library.

Starting from Kalman filters (LGSSM), I climbed the [tower of abstraction](http://bit-player.org/2020/the-teetering-towers-of-abstraction), eventually arriving at the most general formulation of Gaussian filters, the conditional-moments Gaussian filters (CMGFs).

Kalman filters are closed-form solutions for state-space models (SSMs) in which all distributions involved are linear Gaussian. While useful, most SSMs in the real world do not have linear-Gaussian forms for the state dynamics and emission models.

I learned about and implemented extensions of Kalman filters for non-linear dynamics and emission models, namely the extended Kalman filter (EKF), the unscented Kalman filter (UKF), and Gauss-Hermite Kalman Filter (GHKF). I created a nice toy example demonstrating the differences in the scopes (and accuracies) of their Gaussian approximations for non-linear transformations, as shown below.

<table>
  <tr>
    <td>
        <figure>
            <img src="/images/GSOC2022/ekf_post.png" style='width: 100%'>
            <figcaption>EKF-approximated moments.</figcaption>
        </figure>
    </td>
    <td>
        <figure>
            <img src="/images/GSOC2022/ukf_post.png" style='width: 100%'>
            <figcaption>UKF-approximated moments.</figcaption>
        </figure>
    </td>
    <td>
        <figure>
            <img src="/images/GSOC2022/ghkf_post.png" style='width: 100%'>
            <figcaption>GHKF-approximated moments.</figcaption>
        </figure>
    </td>
  </tr>
 </table>

 Next, I implemented the General Gaussian filter (GGF) which unifies the non-linear extensions of KFs into a filter that makes Gaussian approximations to the joint distributions using moment-matching. In addition, I implemented its iterated posterior-linearization extension, which computes expectations with respect to the previous iteration's posterior distribution. However, GGF is still limited in its application by its restriction that the emission model has to be Gaussian.

 I reached the peak of the tower of abstraction for SSMs by implementing the conditional-moments Gaussian filter (CMGF), which relaxes the assumption of Gaussian emission. I created a series of demos demonstrating the utility of CMGF, starting with the binary online logistical regression. As shown below, the CMGF-inferred weights rapidly converge to their MAP estimates.

<table>
  <tr>
    <td>
        <img src="/images/GSOC2022/cmgf_w0.png" style='width: 100%'>
    </td>
    <td>
        <img src="/images/GSOC2022/cmgf_w1.png" style='width: 100%'>
    </td>
    <td>
        <img src="/images/GSOC2022/cmgf_w2.png" style='width: 100%'>
    </td>
  </tr>
 </table> 

Next, I demonstrated that CMGF performs almost identically (in terms of 10-fold cross-validation average accuracies) to many-pass SGD and significantly better than single-pass SGD when applied to multinomial logistic regression.

Also, I demonstrated that CMGF is able to accurately infer latent states based on Poisson likelihood, as shown below.

<table>
  <tr>
    <td>
        <img src="/images/GSOC2022/cmgf_poisson1.png" style='width: 100%'>
    </td>
    <td>
        <img src="/images/GSOC2022/cmgf_poisson2.png" style='width: 100%'>
    </td>
  </tr>
 </table> 

Finally, I demonstrated that CMGF can be used to train MLP-classifiers in a single pass. As shown in the video embedded below, CMGF is able to train an MLP (with two hidden layers) to accurately perform binary classification given a relatively complex training dataset.

<video width=100% controls autoplay>
    <source src="/videos/GSOC2022/cmgf_mlp_classifier.mp4" type="video/mp4">
    Your browser does not support the video tag.  
</video>


### Conclusion

As a beginner open-source contributor, I found GSoC 2022 to be a thoroughly fulfilling and enjoyable learning experience. At the beginning of the summer, I barely understood how Kalman filters worked, and it was incredibly satisfying to gradually discover the subtle differences among the myriad extensions of Kalman filters. Witnessing my implementation of the most general version of them all, the CMGF, perform well in various challenging demos has been very exciting.

I feel extremely grateful to have been a member of the `ssm-jax` team, and I learned so much from everyone that I've worked with. Our incredible mentors, Kevin Murphy and Scott Linderman, fostered a warm and inclusive environment that always encouraged challenging myself without, despite my relative lack of knowlege and experience, ever feeling overwhelming. I greatly look forward to continuing our work (and friendship) with the rest of the team in the future.


### List of PRs

|      **Repo**      |                       **Issue #**                      |                         **PR #**                         |                              **Description**                              |
|:------------------:|:------------------------------------------------------:|:--------------------------------------------------------:|:-------------------------------------------------------------------------:|
| `probml-notebooks` |  [698](https://github.com/probml/pyprobml/issues/698)  | [54](https://github.com/probml/probml-notebooks/pull/54) | Convert LeNet1989 to JAX notebook.                                        |
| `pyprobml`         | [698](https://github.com/probml/pyprobml/issues/698)   | [715](https://github.com/probml/pyprobml/pull/715)       | Convert LeNet1989 to JAX `.py` file.                                      |
| `probml-notebooks` | [708](https://github.com/probml/pyprobml/issues/708)   | [61](https://github.com/probml/probml-notebooks/pull/61) | Translate Random Priors Ensemble demo to JAX.                             |
| `probml-notebooks` | [708](https://github.com/probml/pyprobml/issues/708)   | [69](https://github.com/probml/probml-notebooks/pull/69) | Optimize and improve Random Priors Ensemble demo.                         |
| `JSL`              | [736](https://github.com/probml/pyprobml/issues/736)   | [35](https://github.com/probml/JSL/pull/35)              | Implement fixed lag smoothing for HMM.                                    |
| `JSL`              | N/A                                                    | [57](https://github.com/probml/JSL/pull/57)              | Fix `scipy.special.logit` to `jnp.log`.                                   |
| `ssm-jax`          | [8](https://github.com/probml/ssm-jax/issues/8)        | [26](https://github.com/probml/ssm-jax/pull/26)          | Reimplement `hmm_posterior_sample()`.                                     |
| `ssm-jax`          | [8](https://github.com/probml/ssm-jax/issues/8)        | [28](https://github.com/probml/ssm-jax/pull/28)          | Implement `test_hmm_posterior_sample()` to compare with full joint probs. |
| `ssm-jax`          | [9](https://github.com/probml/ssm-jax/issues/9)        | [29](https://github.com/probml/ssm-jax/pull/29)          | Reimplement `hmm_fixed_lag_smoother()`.                                   |
| `ssm-jax`          | [40](https://github.com/probml/ssm-jax/issues/40)      | [42](https://github.com/probml/ssm-jax/pull/42)          | Implement EKF.                                                            |
| `ssm-jax`          | [32](https://github.com/probml/ssm-jax/issues/32)      | [77](https://github.com/probml/ssm-jax/pull/77)          | Implement EKF-MLP training demo.                                          |
| `ssm-jax`          | [79](https://github.com/probml/ssm-jax/issues/79)      | [88](https://github.com/probml/ssm-jax/pull/88)          | Create `ekf_spiral.py` demo.                                              |
| `ssm-jax`          | [63](https://github.com/probml/ssm-jax/issues/63)      | [111](https://github.com/probml/ssm-jax/pull/111)        | Implement UKF.                                                            |
| `ssm-jax`          | [113](https://github.com/probml/ssm-jax/issues/113)    | [115](https://github.com/probml/ssm-jax/pull/115)        | Create `ukf_spiral.py` demo.                                              |
| `pyprobml`         | [1017](https://github.com/probml/pyprobml/issues/1017) | [1018](https://github.com/probml/pyprobml/pull/1018)     | Add `ekf_vs_ukf.ipynb` demo notebook.                                     |
| `ssm-jax`          | [118](https://github.com/probml/ssm-jax/issues/118)    | [122](https://github.com/probml/ssm-jax/pull/122)        | Implement GGSSM/GGF.                                                      |
| `pyprobml`         | [1082](https://github.com/probml/pyprobml/issues/1082) | [1083](https://github.com/probml/pyprobml/pull/1083)     | Add GHKF comparison to `ekf_vs_ukf.ipynb`.                                |
| `ssm-jax`          | [139](https://github.com/probml/ssm-jax/issues/139)    | [135](https://github.com/probml/ssm-jax/pull/135)        | Implement iterated EKF and iterated EKS.                                  |
| `ssm-jax`          | [144](https://github.com/probml/ssm-jax/issues/144)    | [154](https://github.com/probml/ssm-jax/pull/154)        | Rename classes to more descriptive names.                                 |
| `ssm-jax`          | [140](https://github.com/probml/ssm-jax/issues/140)    | [156](https://github.com/probml/ssm-jax/pull/156)        | Implement CMGF.                                                           |
| `ssm-jax`          | [158](https://github.com/probml/ssm-jax/issues/158)    | [159](https://github.com/probml/ssm-jax/pull/159)        | Create CMGF online logistic regression demo.                              |
| `pyprobml`         | [1104](https://github.com/probml/pyprobml/issues/1104) | [1105](https://github.com/probml/pyprobml/pull/1105)     | Fix ADF logistic regression conversion issue.                             |
| `ssm-jax`          | [178](https://github.com/probml/ssm-jax/issues/178)    | [193](https://github.com/probml/ssm-jax/pull/193)        | Create CMGF multinomial logistic regression demo.                         |
| `ssm-jax`          | [190](https://github.com/probml/ssm-jax/issues/190)    | [200](https://github.com/probml/ssm-jax/pull/200)        | Create CMGF Poisson likelihood inference demo.                            |
| `ssm-jax`          | [191](https://github.com/probml/ssm-jax/issues/191)    | [201](https://github.com/probml/ssm-jax/pull/201)        | Create CMGF-trained MLP-classifier demo.                                  |
