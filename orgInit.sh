# Create the scratch org (uncomment for local development)
# sfdx force:org:delete -u mortgagedemo
sfdx force:org:create -f config/project-scratch-def.json --setalias mortgagedemo --setdefaultusername

# Create the scratch org (uncomment for the SFDX Deployer)
# sfdx shane:org:create -f config/project-scratch-def.json -d 30 -s -n

# Push the metadata into the new scratch org.
sfdx force:source:push

# Grant user Financial Services Cloud licenses
sfdx force:user:permsetlicense:assign -n "Financial Services Cloud Standard"
sfdx force:user:permsetlicense:assign -n "Financial Services Cloud Extension"
sfdx force:user:permsetlicense:assign -n "Mortgage"

# Assign the permset to the default admin user.
sfdx force:user:permset:assign -n cumulus

# Import the data required by the demo
# sfdx automig:dump --objects Account,Contact,Opportunity,ResidentialLoanApplication --outputdir ./data
sfdx automig:load --inputdir ./data

# Activate the custom theme.
sfdx shane:theme:activate -n CumulusMortgage

# Set the default password.
sfdx shane:user:password:set -g User -l User -p salesforce1

# Open the demo org.
sfdx force:org:open