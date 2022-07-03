#' Contribute expert opinion
#'
#' Contribute to open-source effort to collect domain-specific data asset 
#' valuation quantifiers.
#'
#' @param orcid ORCID id 
#' @param field field of research to submit default data value weights for
#' 
#' @details 
#' To see a list of domains see \code{dav::domains}
#' @return NULL - function called for its side effects
#'
#' @examples 
#' 
#' \dontrun{
#' contribute("0000-0002-4343-5851")
#' }
#' @export
contribute <- function(orcid, field = NULL) {
  if(length(orcid) != 1 || !is.character(domain)) E(1)
  # TODO check if user has contributed before
  # TODO overwrite previous contribution?
  data <- rorcid::orcid_id(orcid)[[1L]]
  works <- rorcid::orcid_works(orcid)[[1L]][[1L]]
  contribution <- list(
    name = paste(sep = " ",
      data$name$`given-names`$value %||% E("person_name"),
      data$name$`family-name`$value %||% E("person_name")
    ),
    keywords = data$keywords$keyword$content,
    n_works = nrow(works),
    domain = domain %||% choose_domain()
  )
  NULL
}

choose_domain <- function() {
  list(
    "Arts_Humanities" =
      c("Architecture", "Art", "Asian Studies", "Classics", "Dance",
        "Film, Radio & Television", "History", "Literature", "Music", 
        "Philosophy", "Religion", "Theater"
      ),
    "Social_Sciences" =
      c("Archaeology", "Area Studies", "Business & Economics", "Communication",
        "Criminology & Penology", "Cultural Studies", "Demography",
        "Education & Educational Research", "Ethnic Studies", "Family Studies",
        "Geography", "Government & Law", "International Relations",
        "Linguistics", "Psychology", "Public Administration", "Social Issues", 
        "Social Work", "Sociology", "Urban Studies", "Women's Studies"
      ),
    "Life_Sciences" =
      c("Agriculture", "Allergy", "Anatomy & Morphology", "Anesthesiology",
        "Anthropology", "Behavioral Sciences", "Biochemistry & Molecular Biology", 
        "Biodiversity & Conservation", "Biophysics", 
        "Biotechnology & Applied Microbiology",
        "Cardiovascular System & Cardiology", "Cell Biology",
        "Critical Care Medicine", "Dentistry, Oral Surgery & Medicine",
        "Dermatology", "Developmental Biology", "Emergency Medicine", 
        "Endocrinology & Metabolism", "Entomology",
        "Environmental Sciences & Ecology", "Evolutionary Biology", "Fisheries",
        "Food Science & Technology", "Forestry", "Gastroenterology & Hepatology",
        "General & Internal Medicine", "Genetics & Heredity",
        "Geriatrics & Gerontology", "Health Care Sciences & Services",
        "Hematology", "Immunology", "Infectious Diseases", 
        "Integrative & Complementary Medicine", "Legal Medicine",
        "Marine & Freshwater Biology", "Mathematical & Computational Biology",
        "Medical Ethics", "Medical Informatics", "Medical Laboratory Technology",
        "Microbiology", "Mycology", "Neurosciences & Neurology", "Nursing",
        "Nutrition & Dietetics", "Obstetrics & Gynecology", "Oncology",
        "Ophthalmology", "Orthopedics", "Otorhinolaryngology", "Paleontology",
        "Parasitology", "Pathology", "Pediatrics", "Pharmacology & Pharmacy",
        "Physiology", "Plant Sciences", "Psychiatry", 
        "Public, Environmental & Occupational Health",
        "Radiology, Nuclear Medicine & Medical Imaging",
        "Rehabilitation", "Reproductive Biology",
        "Research & Experimental Medicine", "Respiratory System", 
        "Rheumatology", "Sport Sciences", "Substance Abuse", "Surgery", 
        "Toxicology", "Transplantation", "Tropical Medicine",
        "Urology & Nephrology", "Veterinary Sciences", "Virology", "Zoology"
      ),
    "Physical_Sciences" = 
      c("Astronomy & Astrophysics", "Chemistry", "Crystallography", 
        "Electrochemistry", "Geochemistry & Geophysics", "Geology",
        "Mathematics", "Meteorology & Atmospheric Sciences", "Mineralogy",
        "Mining & Mineral Processing", "Oceanography", "Optics",
        "Physical Geography", "Physics", "Polymer Science", "Thermodynamics", 
        "Water Resources"
      ),
    "Technology" =
      c("Acoustics", "Automation & Control Systems", "Computer Science",
        "Construction & Building Technology", "Energy & Fuels", 
        "Engineering", "Imaging Science & Photographic Technology",
        "Information Science & Library Science",
        "Instruments & Instrumentation", "Materials Science", "Mechanics",
        "Metallurgy & Metallurgical Engineering", "Microscopy", 
        "Nuclear Science & Technology",
        "Operations Research & Management Science", "Remote Sensing", 
        "Robotics", "Spectroscopy", "Telecommunications", "Transportation")
  )
}
choose_domain()

c("Acoustics", "Automation & Control Systems", "Computer Science", "Construction & Building Technology", "Energy & Fuels", "Engineering", "Imaging Science & Photographic Technology", "Information Science & Library Science", "Instruments & Instrumentation", "Materials Science", "Mechanics", "Metallurgy & Metallurgical Engineering", "Microscopy", "Nuclear Science & Technology", "Operations Research & Management Science", "Remote Sensing", "Robotics", "Spectroscopy", "Telecommunications", "Transportation")
