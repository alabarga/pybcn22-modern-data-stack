//// CHANGE name=change0 dependencies="vocabularies.concept.change0,vocabulary.change0"
CREATE TABLE IF NOT EXISTS vocabularies.source_to_concept_map
(
    source_concept_id integer NOT NULL,
    target_concept_id integer NOT NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    source_code text NOT NULL
      CONSTRAINT chk_source_to_concept_map_source_code CHECK ( length(source_code) <= 50 ),
    source_vocabulary_id text NOT NULL
      CONSTRAINT chk_source_to_concept_map_source_vocabulary_id CHECK (length(source_vocabulary_id) <= 20),
    target_vocabulary_id text NOT NULL
        CONSTRAINT chk_source_to_concept_map_target_vocabulary_id CHECK ( length(target_vocabulary_id) <= 20),
    source_code_description text
      CONSTRAINT chk_source_to_concept_map_source_code_description CHECK (coalesce(length(source_code_description), 0) <= 255),
    invalid_reason text
      CONSTRAINT chk_source_to_concept_map_invalid_reason CHECK ( coalesce(length(invalid_reason), 0) <= 1),
    CONSTRAINT xpk_source_to_concept_map_id PRIMARY KEY (source_vocabulary_id, target_concept_id, source_code, valid_end_date),
    CONSTRAINT fpk_source_to_concept_map_target_concept_id FOREIGN KEY (target_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_source_to_concept_map_source_vocabulary_id FOREIGN KEY (source_vocabulary_id)
        REFERENCES vocabularies.vocabulary (vocabulary_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_source_to_concept_map_target_vocabulary_id FOREIGN KEY (target_vocabulary_id)
        REFERENCES vocabularies.vocabulary (vocabulary_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO

//// CHANGE name=change2 dependencies=change0
COMMENT ON TABLE vocabularies.source_to_concept_map
    IS 'The source to concept map table is a legacy data structure within the OMOP Common Data Model, recommended for use in ETL processes to maintain local source codes which are not available as Concepts in the Standardized Vocabularies, and to establish mappings for each source code into a Standard Concept as target_concept_ids that can be used to populate the Common Data Model tables. The SOURCE_TO_CONCEPT_MAP table is no longer populated with content within the Standardized Vocabularies published to the OMOP community.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.source_code
    IS 'The source code being translated into a Standard Concept.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.source_concept_id
    IS 'A foreign key to the Source Concept that is being translated into a Standard Concept.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.source_vocabulary_id
    IS 'A foreign key to the VOCABULARY table defining the vocabulary of the source code that is being translated to a Standard Concept.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.source_code_description
    IS 'An optional description for the source code. This is included as a convenience to compare the description of the source code to the name of the concept.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.target_concept_id
    IS 'A foreign key to the target Concept to which the source code is being mapped.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.target_vocabulary_id
    IS 'A foreign key to the VOCABULARY table defining the vocabulary of the target Concept.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.valid_start_date
    IS 'The date when the mapping instance was first recorded.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.valid_end_date
    IS 'The date when the mapping instance became invalid because it was deleted or superseded (updated) by a new relationship. Default value is 31-Dec-2099.';

COMMENT ON COLUMN vocabularies.source_to_concept_map.invalid_reason
    IS 'Reason the mapping instance was invalidated. Possible values are D (deleted), U (replaced with an update) or NULL when valid_end_date has the default value.';

GO
