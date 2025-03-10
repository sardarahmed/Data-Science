import subprocess
import path


# Define paths
spmf_jar = "E:\Data Science\TER avec Nadjib Lazaar\TER2\SPMF_VS_CHOCO-MINING\spmf.jar"  # Path to your SPMF JAR file
input_file = "dense_market_basket.txt"  # Your dataset file
output_file = "TER avec Nadjib Lazaar\TER2\SPMF_VS_CHOCO-MINING\output.txt"  # Where results will be saved

# Run Apriori in SPMF (Example: min support = 50%)
command = [
    "java", "-jar", spmf_jar,
    "run", "Apriori", input_file, output_file, "50%"  # Change min support as needed
]

# Execute command
subprocess.run(command)

# Read output
with open(output_file, "r") as f:
    results = f.readlines()

# Print results
print("Frequent Itemsets Found:")
for line in results[:10]:  # Show first 10 results
    print(line.strip())
