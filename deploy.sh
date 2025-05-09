#!/bin/bash
# Main deployment script for the telecom log analysis application
# For Tesla P40 GPU environment

echo "========================================================"
echo "Telecom Log Analysis Application Deployment"
echo "Optimized for Tesla P40 GPU"
echo "========================================================"
echo ""

# Make all scripts executable
chmod +x deploy/*.sh

# Step 0: Optimize GPU
echo "Step 0: Optimizing Tesla P40 GPU for deep learning workloads..."
echo "----------------------------"
./deploy/optimize_gpu.sh
echo ""

# Step 1: Download models
echo "Step 1: Downloading LLM models..."
echo "----------------------------"
./deploy/download_models.sh
echo ""

# Step 2: Setup Milvus
echo "Step 2: Setting up Milvus vector database..."
echo "----------------------------"
./deploy/setup_milvus.sh
echo ""

# Step 3: Start Milvus
echo "Step 3: Starting Milvus vector database..."
echo "----------------------------"
cd milvus-config && docker-compose up -d && cd ..
echo ""

# Step 4: Deploy the application
echo "Step 4: Deploying the application..."
echo "----------------------------"
./deploy/deploy_app.sh
echo ""

# Step 5: Start the LLM server
echo "Step 5: Starting the LLM server..."
echo "----------------------------"
sudo systemctl start llm-server
echo ""

# Step 6: Start the application
echo "Step 6: Starting the application..."
echo "----------------------------"
sudo systemctl start telecom-log-analysis
echo ""

echo "========================================================"
echo "Deployment complete!"
echo "The telecom log analysis application should now be running at:"
echo "http://localhost:5000"
echo ""
echo "Make sure to update the .env file with your specific configuration:"
echo "- Add your PERPLEXITY_API_KEY if you want to use that service"
echo "- Update any other configuration variables as needed"
echo ""
echo "To check status:"
echo "sudo systemctl status llm-server"
echo "sudo systemctl status telecom-log-analysis"
echo ""
echo "To view logs:"
echo "sudo journalctl -u llm-server -f"
echo "sudo journalctl -u telecom-log-analysis -f"
echo "========================================================"