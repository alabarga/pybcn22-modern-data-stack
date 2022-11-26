//// CHANGE name=change0 dependencies="concept.change0,relationship.change0"
CREATE TABLE IF NOT EXISTS vocabularies.concept_relationship
(
    concept_id_1 integer NOT NULL,
    concept_id_2 integer NOT NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    relationship_id text NOT NULL
      CONSTRAINT chk_concept_relationship_relationship_id CHECK (length(relationship_id) <= 20),
    invalid_reason text,
    CONSTRAINT xpk_concept_relationship_id PRIMARY KEY (concept_id_1, concept_id_2, relationship_id),
    CONSTRAINT fpk_concept_relationship_concept_id_1 FOREIGN KEY (concept_id_1)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_concept_relationship_concept_id_2 FOREIGN KEY (concept_id_2)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_concept_relationship_relationship_id FOREIGN KEY (relationship_id)
        REFERENCES vocabularies.relationship (relationship_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT chk_invalid_reason CHECK (COALESCE(invalid_reason, 'D'::character varying)::text = 'D'::text)
)
TABLESPACE pg_default;

GO

//// CHANGE name=change2 dependencies=change0
COMMENT ON TABLE vocabularies.concept_relationship
    IS 'The CONCEPT_RELATIONSHIP table contains records that define direct relationships between any two Concepts and the nature or type of the relationship. Each type of a relationship is defined in the [RELATIONSHIP](https://github.com/OHDSI/CommonDataModel/wiki/RELATIONSHIP) table.';

COMMENT ON COLUMN vocabularies.concept_relationship.concept_id_1
    IS 'A foreign key to a Concept in the [CONCEPT](https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT) table associated with the relationship. Relationships are directional, and this field represents the source concept designation.';

COMMENT ON COLUMN vocabularies.concept_relationship.concept_id_2
    IS 'A foreign key to a Concept in the [CONCEPT](https://github.com/OHDSI/CommonDataModel/wiki/CONCEPT) table associated with the relationship. Relationships are directional, and this field represents the destination concept designation.';

COMMENT ON COLUMN vocabularies.concept_relationship.relationship_id
    IS 'A unique identifier to the type or nature of the Relationship as defined in the [RELATIONSHIP](https://github.com/OHDSI/CommonDataModel/wiki/RELATIONSHIP) table.';

COMMENT ON COLUMN vocabularies.concept_relationship.valid_start_date
    IS 'The date when the instance of the Concept Relationship is first recorded.';

COMMENT ON COLUMN vocabularies.concept_relationship.valid_end_date
    IS 'The date when the Concept Relationship became invalid because it was deleted or superseded (updated) by a new relationship. Default value is 31-Dec-2099.';

COMMENT ON COLUMN vocabularies.concept_relationship.invalid_reason
    IS 'Reason the relationship was invalidated. Possible values are ''D'' (deleted), ''U'' (replaced with an update) or NULL when valid_end_date has the default value.';

GO

//// CHANGE name=change3
CREATE INDEX IF NOT EXISTS idx_concept_relationship_concept_id_2
    ON vocabularies.concept_relationship USING btree
    (concept_id_2 ASC NULLS LAST)
    TABLESPACE pg_default;

GO
