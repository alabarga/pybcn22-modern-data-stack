//// CHANGE name=change0 dependencies="public.00_migration.change0"
CREATE TABLE IF NOT EXISTS vocabularies.concept_synonym
(
    concept_id integer NOT NULL,
    language_concept_id integer NOT NULL,
    concept_synonym_name text NOT NULL,
    CONSTRAINT uq_concept_synonym UNIQUE (concept_id, concept_synonym_name, language_concept_id),
    CONSTRAINT fpk_concept_synonym_concept FOREIGN KEY (concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_concept_synonym_language_concept FOREIGN KEY (language_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT chk_csyn_concept_synonym_name CHECK (concept_synonym_name::text <> ''::text)
)
TABLESPACE pg_default;

GO

//// CHANGE name=change2 dependencies=change0
COMMENT ON TABLE vocabularies.concept_synonym
    IS 'The CONCEPT_SYNONYM table is used to store alternate names and descriptions for Concepts.';

COMMENT ON COLUMN vocabularies.concept_synonym.concept_id
    IS 'A foreign key to the Concept in the CONCEPT table.';

COMMENT ON COLUMN vocabularies.concept_synonym.concept_synonym_name
    IS 'The alternative name for the Concept.';

COMMENT ON COLUMN vocabularies.concept_synonym.language_concept_id
    IS 'A foreign key to a Concept representing the language.';

GO

//// CHANGE name=change3
CREATE INDEX IF NOT EXISTS idx_concept_synonym_concept_id
    ON vocabularies.concept_synonym USING btree
    (concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO
