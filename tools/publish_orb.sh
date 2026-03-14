#!/usr/bin/env bash
set -e

NAMESPACE="linia"
ORB_NAME="ecs-services-deploy"
DEV_TAG="alpha"
ORB_DIR="ecs-services-deploy"
PACKED_ORB="orb-packed.yml"

echo "📦 Packing orb..."
circleci orb pack $ORB_DIR > $PACKED_ORB

echo "🔍 Validating orb..."
circleci orb validate $PACKED_ORB

echo "🚀 Publishing development orb..."
circleci orb publish $PACKED_ORB ${NAMESPACE}/${ORB_NAME}@dev:${DEV_TAG}

echo "📈 Promoting to first version..."
circleci orb publish promote ${NAMESPACE}/${ORB_NAME}@dev:${DEV_TAG} patch

echo "✅ Orb published successfully!"
echo ""
echo "Use it with:"
echo "${NAMESPACE}/${ORB_NAME}@0.0.1"