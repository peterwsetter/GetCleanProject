cleanUpNames <- function(messyNames) {
        fixes <- c("\\(", "\\)", "\\-", "\\,")
        cleanNames <- messyNames
        for (fix in fixes) {
                cleanNames <- gsub(fix, "", cleanNames,)
        }
        cleanNames <- gsub("BodyBody", "Body", cleanNames,)
        cleanNames <- gsub("mean", "Mean", cleanNames,)
        cleanNames <- gsub("std", "Std", cleanNames,)
        cleanNames
}