ARG CUDA_VERSION=12.2.0
ARG IMAGE_DISTRO=ubuntu22.04

FROM nvidia/cuda:${CUDA_VERSION}-devel-${IMAGE_DISTRO} AS builder

WORKDIR /build

COPY . /build/

RUN make COMPUTE=80 CUDA_VERSION=${CUDA_VERSION} IMAGE_DISTRO=${IMAGE_DISTRO}

FROM nvidia/cuda:${CUDA_VERSION}-runtime-${IMAGE_DISTRO}

COPY --from=builder /build/gpu_burn /app/
COPY --from=builder /build/compare.ptx /app/

WORKDIR /app

CMD ["./gpu_burn", "60"]

# ./gpu_burn -m 100% -tc 86400
