business <- c("Ownership", "Longevity", "Encryption", "Documentation",
      "Precision", "Objectivity", "Frequency", "Scarcity", "Relevance",
      "Validity", "Clarity", "Conciseness", "Volume", "Usability",
      "Consistency", "Accuracy", "Accessibility", "Completeness",
      "Timeliness", "Integrity")

scholar <- c("Frequency", "Scarcity", "Scalability", "Relevance", "Longevity",
      "Encryption", "Documentation", "Completeness", "Conciseness",
      "Volume", "Usability", "Sensitivity", "Security", "Ownership",
      "Consistency", "Accessibility", "Timeliness", "Integrity")

attributes <- union(business, scholar)

sort(attributes)
