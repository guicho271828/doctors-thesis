# Q1. List up to four keywords/key phrases from your paper from the following list:

search
planning

# Q2. Please state in no more than 150 words why your work is important to other researchers in Artificial Intelligence and how they could make use of your results.

This paper investigates and improves the tie-breaking strategies for A\* in depth. To our knowledge, such an in-depth analysis is lacking in the literature. We break some conventional wisdoms regarding tiebreaking for A\* and propose several improvements. Since A\* is a standard algorithm for cost-optimal search, our contribution advances the state-of-the-art and benefits many applications.

In particular, we focus on a particular type of problems with a clear objective function e.g. resource, preference etc., which models the more realistic optimization problems. We show that these problems pose a challenge to the existing tiebreaking strategies and our method outperforms the existing ones.

# Q3. Please list 1 - 3 papers previously published in JAIR that are closest to your work,

Richter, S., & Westphal, M. (2010). The LAMA Planner: Guiding Cost-Based Anytime Planning with Landmarks. J. Artif. Intell. Res.(JAIR), 39(1), 127–177.

This paper proposes the additive combination of distance-to-go (plan length) estimates and cost estimates for anytime suboptimal planning with cost refinement. The motivation behind this technique is similar to ours (solving the domains with zero-cost actions) while they allow suboptimality and we targets cost-optimal plans.

Hoffmann, J. (2005). Where ’Ignoring Delete Lists’ Works: Local Search Topology in Planning Benchmarks. J. Artif. Intell. Res.(JAIR), 24, 685–758.

This paper analyzes the search space structure of various individual planning domains in the context of local search. Our paper, in contrast, addresses the specific problem that arise in the cost-optimal planning with zero-cost edges and is more focused on the search algorithm improvement.

# Q4. If any part of this paper has been previously published,

This paper is a significantly extended version of the AAAI-16 paper by the same authors. Over 50% of the paper is new material. The additions to the conference paper are the following:

1.  Introduction of deterministic depth-based diversification strategy (as opposed to the randomized version in the conference paper), and its theoretical analysis in Section 6.

2.  A new, thorough empirical analysis of the behavior of depth-based diversification in Section 7.

3.  We propose a new framework for treating A\* as a sequence of satisficing searches on a set of f-cost plateaus (Section 8).

4.  Based on the new framework, we propose and evaluate tie-breaking strategies which incorporates distance-to-go estimates (Section 9)

# abstract

In this paper, we investigate and improve tie-breaking strategies for cost-optimal search using A\*. We first experimentally analyze the performance of common tie-breaking strategies that break ties according to the heuristic value of the nodes.  We find that tie-breaking strategy has a significant impact on search algorithm performance when there are 0-cost operators that induce large plateau regions in the search space. With this in mind, we develop two new classes of tie-breaking strategy. The first class of strategy we propose is based on a depth metric which measures the distance from the entrance to the plateau. We  proposes a new, depth diversification strategy which significantly outperforms standard strategies on domains with 0-cost actions. We provide both a theoretical analysis and an empirical analysis supporting these results. Next, we propose a new framework for interpreting search as a series of satisficing searches within plateaus consisting of nodes with the same f-cost. Based on this framework, we investigate a second class of tie-breaking strategy which is a  multi-heuristic tie-breaking strategy which embeds inadmissible, distance-to-go variations of various heuristics within an admissible search. This is shown to further improve the performance in combination with the depth metric.
