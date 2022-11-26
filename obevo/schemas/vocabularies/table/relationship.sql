//// CHANGE name=change0
CREATE TABLE IF NOT EXISTS vocabularies.relationship
(
    relationship_concept_id integer NOT NULL,
    relationship_id text NOT NULL
      CONSTRAINT chk_relationship_relationship_id CHECK(length(relationship_id) <= 20),
    relationship_name text NOT NULL
      CONSTRAINT chk_relationship_relationship_name CHECK(length(relationship_name) <= 255),
    is_hierarchical text NOT NULL
      CONSTRAINT chk_relationship_is_hierachical CHECK(length(is_hierarchical) <= 1),
    defines_ancestry text NOT NULL
      CONSTRAINT chk_relationship_defines_ancestry CHECK(length(defines_ancestry) <= 1),
    reverse_relationship_id text NOT NULL
      CONSTRAINT chk_relationship_reverse_relationship_id CHECK(length(reverse_relationship_id) <= 20),
    CONSTRAINT xpk_relationship_id PRIMARY KEY (relationship_id),
    CONSTRAINT fpk_relationship_relationship_concept_id FOREIGN KEY (relationship_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_relationship_reverse_relationship_id FOREIGN KEY (reverse_relationship_id)
        REFERENCES vocabularies.relationship (relationship_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO


//// CHANGE name=change2 dependencies=change0
COMMENT ON TABLE vocabularies.relationship
    IS 'The RELATIONSHIP table provides a reference list of all types of relationships that can be used to associate any two concepts in the CONCEPT_RELATIONSHP table.';

COMMENT ON COLUMN vocabularies.relationship.relationship_id
    IS 'The type of relationship captured by the relationship record.';

COMMENT ON COLUMN vocabularies.relationship.relationship_name
    IS 'The text that describes the relationship type.';

COMMENT ON COLUMN vocabularies.relationship.is_hierarchical
    IS 'Defines whether a relationship defines concepts into classes or hierarchies. Values are 1 for hierarchical relationship or 0 if not.';

COMMENT ON COLUMN vocabularies.relationship.defines_ancestry
    IS 'Defines whether a hierarchical relationship contributes to the concept_ancestor table. These are subsets of the hierarchical relationships. Valid values are 1 or 0.';

COMMENT ON COLUMN vocabularies.relationship.reverse_relationship_id
    IS 'The identifier for the relationship used to define the reverse relationship between two concepts.';

COMMENT ON COLUMN vocabularies.relationship.relationship_concept_id
    IS 'A foreign key that refers to an identifier in the CONCEPT table for the unique relationship concept.';

GO
