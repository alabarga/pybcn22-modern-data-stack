//// CHANGE name=change0 dependencies="concept.change0"
CREATE TABLE IF NOT EXISTS vocabularies.vocabulary
(
    vocabulary_concept_id integer NOT NULL,
    vocabulary_id text NOT NULL
      CONSTRAINT chk_vocabulary_vocabulary_id CHECK(length(vocabulary_id) <= 20),
    vocabulary_name text NOT NULL
      CONSTRAINT chk_vocabulary_vocabulary_name CHECK(length(vocabulary_name) <= 255),
    vocabulary_reference text
      CONSTRAINT chk_vocabulary_vocabulary_reference CHECK(length(vocabulary_reference) <= 255),
    vocabulary_version text
      CONSTRAINT chk_vocabulary_vocabulary_version CHECK(length(vocabulary_version) <= 255),
    CONSTRAINT xpk_vocabulary_id PRIMARY KEY (vocabulary_id),
    CONSTRAINT fpk_vocabulary_vocabulary_concept_id FOREIGN KEY (vocabulary_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO

//// CHANGE name=load_data dependencies=change0
copy vocabularies.vocabulary (vocabulary_id,vocabulary_name,vocabulary_reference,vocabulary_version,vocabulary_concept_id) from program 'curl https://storage.googleapis.com/iomed-public-data/OMOP-CDM/28-JAN-22/VOCABULARY.csv.gz -k -s | zcat' with csv header delimiter E'\t' QUOTE E'\r';


//// CHANGE name=change2 dependencies=load_data
COMMENT ON TABLE vocabularies.vocabulary
    IS 'The VOCABULARY table includes a list of the Vocabularies collected from various sources or created de novo by the OMOP community. This reference table is populated with a single record for each Vocabulary source and includes a descriptive name and other associated attributes for the Vocabulary.';

COMMENT ON COLUMN vocabularies.vocabulary.vocabulary_id
    IS 'A unique identifier for each Vocabulary, such as ICD9CM, SNOMED, Visit.';

COMMENT ON COLUMN vocabularies.vocabulary.vocabulary_name
    IS 'The name describing the vocabulary, for example "International Classification of Diseases, Ninth Revision, Clinical Modification, Volume 1 and 2 (NCHS)" etc.';

COMMENT ON COLUMN vocabularies.vocabulary.vocabulary_reference
    IS 'External reference to documentation or available download of the about the vocabulary.';

COMMENT ON COLUMN vocabularies.vocabulary.vocabulary_version
    IS 'Version of the Vocabulary as indicated in the source.';

COMMENT ON COLUMN vocabularies.vocabulary.vocabulary_concept_id
    IS 'A foreign key that refers to a standard concept identifier in the CONCEPT table for the Vocabulary the VOCABULARY record belongs to.';

GO
