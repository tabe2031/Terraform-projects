terraform {
    backend "s3" {
        key = "terraform/tfstate.tfstate"
        bucket = "bootcamp30-7-tabe"
        region = "us-west-2"
        access_key = "AKIARZVWRFSYEAV7K5P7"
        secret_key = "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"
    }
}
