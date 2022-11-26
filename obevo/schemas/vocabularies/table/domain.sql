//// CHANGE name=change0 dependencies="concept.change0"
CREATE TABLE IF NOT EXISTS vocabularies.domain
(
    domain_concept_id integer,
    domain_id text NOT NULL
      CONSTRAINT chk_domain_domain_id CHECK(length(domain_id) <= 20),
    domain_name text NOT NULL
      CONSTRAINT chk_domain_domain_name CHECK(length(domain_name) <= 255),
    CONSTRAINT xpk_domain_id PRIMARY KEY (domain_id),
    CONSTRAINT fpk_domain_domain_concept_id FOREIGN KEY (domain_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO

//// CHANGE name=load_data dependencies=change0
copy vocabularies.domain (domain_id, domain_name, domain_concept_id) from program 'curl https://storage.googleapis.com/iomed-public-data/OMOP-CDM/28-JAN-22/DOMAIN.csv.gz -k -s | zcat' with csv header delimiter E'\t' QUOTE E'\r';


//// CHANGE name=change2 dependencies=load_data
COMMENT ON TABLE vocabularies.domain
    IS 'The DOMAIN table includes a list of OMOP-defined Domains the Concepts of the Standardized Vocabularies can belong to. A Domain defines the set of allowable Concepts for the standardized fields in the CDM tables. For example, the "Condition" Domain contains Concepts that describe a condition of a patient, and these Concepts can only be stored in the condition_concept_id field of the [CONDITION_OCCURRENCE](https://github.com/OHDSI/CommonDataModel/wiki/CONDITION_OCCURRENCE) and [CONDITION_ERA](https://github.com/OHDSI/CommonDataModel/wiki/CONDITION_ERA) tables. This reference table is populated with a single record for each Domain and includes a descriptive name for the Domain.';

COMMENT ON COLUMN vocabularies.domain.domain_id
    IS 'A unique key for each domain.';

COMMENT ON COLUMN vocabularies.domain.domain_name
    IS 'The name describing the Domain, e.g. "Condition", "Procedure", "Measurement" etc.';

COMMENT ON COLUMN vocabularies.domain.domain_concept_id
    IS 'A foreign key that refers to an identifier in the [CONCEPT](https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT) table for the unique Domain Concept the Domain record belongs to.';

GO
