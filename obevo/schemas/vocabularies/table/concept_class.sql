//// CHANGE name=change0 dependencies="concept.change0"
CREATE TABLE IF NOT EXISTS vocabularies.concept_class
(
    concept_class_concept_id integer NOT NULL,
    concept_class_id text NOT NULL
      CONSTRAINT chk_concept_class_concept_class_id CHECK (length(concept_class_id) <= 20),
    concept_class_name text NOT NULL
      CONSTRAINT chk_concept_class_concept_class_name CHECK (length(concept_class_name) <= 255),
    CONSTRAINT xpk_concept_class PRIMARY KEY (concept_class_id),
    CONSTRAINT fpk_concept_class_concept_class_concept_id FOREIGN KEY (concept_class_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO

//// CHANGE name=load_data dependencies=change0
copy vocabularies.concept_class (concept_class_id, concept_class_name, concept_class_concept_id) from program 'curl https://storage.googleapis.com/iomed-public-data/OMOP-CDM/28-JAN-22/CONCEPT_CLASS.csv.gz -k -s | zcat' with csv header delimiter E'\t' QUOTE E'\r';

//// CHANGE name=change2 dependencies=load_data
COMMENT ON TABLE vocabularies.concept_class
    IS 'The CONCEPT_CLASS table is a reference table, which includes a list of the classifications used to differentiate Concepts within a given Vocabulary. This reference table is populated with a single record for each Concept Class:';

COMMENT ON COLUMN vocabularies.concept_class.concept_class_id
    IS 'A unique key for each class.';

COMMENT ON COLUMN vocabularies.concept_class.concept_class_name
    IS 'The name describing the Concept Class, e.g. "Clinical Finding", "Ingredient", etc.';

COMMENT ON COLUMN vocabularies.concept_class.concept_class_concept_id
    IS 'A foreign key that refers to an identifier in the [CONCEPT](https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT) table for the unique Concept Class the record belongs to.';

GO
