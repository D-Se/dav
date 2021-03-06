% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sleuth.R
\name{hash}
\alias{hash}
\title{Hash an \R object}
\usage{
hash(asset, algorithm)
}
\arguments{
\item{asset}{an \R object}

\item{algorithm}{xxHash variant to compute.}
}
\value{
\code{chr} an xxHash string of the asset.
}
\description{
\code{dav} uses 64-bit xxh3 (v0.8.1) of Yann Collet's xxHash algorithm to
represent known data asset valuations. Note that it is NOT cryptographic.
}
\details{
\subsection{xxHash rationale}{

Data asset valuation needs reproducibility, transparency and reduction of
computational overheads.

In general, xxHash is a fast CPU and platform independent solution for
arbitrary sized data. xxh3, the default, uses SIMD and 64-bit arithmetic
that allows it to achieve near RAM sequential read speeds. The algorithm
shows good speeds on small and large sets. This ensures that different
sizes of data assets can be valued at different precision without becoming a
bottleneck.

The 64-bit version has a low collision rate that passes known benchmarks, and
can be directly obtained from a 128-bit implementation, future proofing
valuation processes as data holdings evole.
}
}
\seealso{
\code{\link[=serialize]{base::serialize}} for serializable \R
objects.
}
