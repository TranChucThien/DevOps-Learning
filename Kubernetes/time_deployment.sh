#!/bin/bash
DESIRED_REPLICAS=50

# Scale deployment
kubectl scale deployment inflate --replicas=$DESIRED_REPLICAS


echo "🔍 Waiting for all pods to be Ready..."

# Lấy số replicas mong muốn


START=$(date +%s)

# Đợi đến khi đủ số pod
while true; do
    CURRENT_REPLICAS=$(kubectl get pods -l app=inflate --field-selector=status.phase=Running | grep -c '^inflate')
    if [ "$CURRENT_REPLICAS" -ge "$DESIRED_REPLICAS" ]; then
        break
    fi
    echo "⏳ Pods running: $CURRENT_REPLICAS/$DESIRED_REPLICAS"
    sleep 1
done



# Đợi tất cả pod Ready
#kubectl wait --for=condition=Ready pods -l app=inflate --timeout=600s

# Lấy thời gian kết thúc
END=$(date +%s)

# Tính thời gian
echo "✅ All pods are Ready!"
echo "⏱ Time to Ready: $((END - START)) seconds"