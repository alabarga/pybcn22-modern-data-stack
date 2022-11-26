//// CHANGE name=change0
CREATE TABLE IF NOT EXISTS vocabularies.concept_ancestor
(
    ancestor_concept_id integer NOT NULL,
    descendant_concept_id integer NOT NULL,
    min_levels_of_separation integer NOT NULL,
    max_levels_of_separation integer NOT NULL,
    CONSTRAINT xpk_concept_ancestor PRIMARY KEY (ancestor_concept_id, descendant_concept_id),
    CONSTRAINT fpk_concept_ancestor_ancestor_concept_id FOREIGN KEY (ancestor_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_concept_ancestor_descendant_concept_id FOREIGN KEY (descendant_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO

//// CHANGE name=change2 dependencies=change0
COMMENT ON TABLE vocabularies.concept_ancestor
    IS 'The CONCEPT_ANCESTOR table is designed to simplify observational analysis by providing the complete hierarchical relationships between Concepts. Only direct parent-child relationships between Concepts are stored in the CONCEPT_RELATIONSHIP table. To determine higher level ancestry connections, all individual direct relationships would have to be navigated at analysis time. The CONCEPT_ANCESTOR table includes records for all parent-child relationships, as well as grandparent-grandchild relationships and those of any other level of lineage. Using the CONCEPT_ANCESTOR table allows for querying for all descendants of a hierarchical concept. For example, drug ingredients and drug products are all descendants of a drug class ancestor.  This table is entirely derived from the CONCEPT, CONCEPT_RELATIONSHIP and RELATIONSHIP tables.';

COMMENT ON COLUMN vocabularies.concept_ancestor.ancestor_concept_id
    IS 'A foreign key to the concept in the concept table for the higher-level concept that forms the ancestor in the relationship.';

COMMENT ON COLUMN vocabularies.concept_ancestor.descendant_concept_id
    IS 'A foreign key to the concept in the concept table for the lower-level concept that forms the descendant in the relationship.';

COMMENT ON COLUMN vocabularies.concept_ancestor.min_levels_of_separation
    IS 'The minimum separation in number of levels of hierarchy between ancestor and descendant concepts. This is an attribute that is used to simplify hierarchic analysis.';

COMMENT ON COLUMN vocabularies.concept_ancestor.max_levels_of_separation
    IS 'The maximum separation in number of levels of hierarchy between ancestor and descendant concepts. This is an attribute that is used to simplify hierarchic analysis.';

GO

//// CHANGE name=change3
CREATE INDEX IF NOT EXISTS idx_concept_ancestor_descendant_concept_id
    ON vocabularies.concept_ancestor USING btree
    (descendant_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO
