//// CHANGE name=change0
CREATE TABLE IF NOT EXISTS vocabularies.drug_strength
(
    drug_concept_id integer NOT NULL,
    ingredient_concept_id integer NOT NULL,
    valid_start_date date NOT NULL,
    valid_end_date date NOT NULL,
    amount_unit_concept_id integer,
    numerator_unit_concept_id integer,
    denominator_unit_concept_id integer,
    box_size integer,
    amount_value numeric,
    numerator_value numeric,
    denominator_value numeric,
    invalid_reason text
      CONSTRAINT chk_drug_strength_invalid_reason CHECK ( coalesce(length(invalid_reason), 0) <= 1 ),
    CONSTRAINT xpk_drug_strength PRIMARY KEY (drug_concept_id, ingredient_concept_id),
    CONSTRAINT fpk_drug_strength_drug_concept_id FOREIGN KEY (drug_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_drug_strength_ingredient_concept_id FOREIGN KEY (ingredient_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_drug_strength_amount_unit_concept_id FOREIGN KEY (amount_unit_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_drug_strength_numerator_unit_concept_id FOREIGN KEY (numerator_unit_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT fpk_drug_strength_denominator_unit_concept_id FOREIGN KEY (denominator_unit_concept_id)
        REFERENCES vocabularies.concept (concept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
)
TABLESPACE pg_default;

GO

//// CHANGE name=change2 dependencies=change0
COMMENT ON TABLE vocabularies.drug_strength
    IS 'The DRUG_STRENGTH table contains structured content about the amount or concentration and associated units of a specific ingredient contained within a particular drug product. This table is supplemental information to support standardized analysis of drug utilization.';

COMMENT ON COLUMN vocabularies.drug_strength.drug_concept_id
    IS 'A foreign key to the Concept in the CONCEPT table representing the identifier for Branded Drug or Clinical Drug Concept.';

COMMENT ON COLUMN vocabularies.drug_strength.ingredient_concept_id
    IS 'A foreign key to the Concept in the CONCEPT table, representing the identifier for drug Ingredient Concept contained within the drug product.';

COMMENT ON COLUMN vocabularies.drug_strength.amount_value
    IS 'The numeric value associated with the amount of active ingredient contained within the product.';

COMMENT ON COLUMN vocabularies.drug_strength.amount_unit_concept_id
    IS 'A foreign key to the Concept in the CONCEPT table representing the identifier for the Unit for the absolute amount of active ingredient.';

COMMENT ON COLUMN vocabularies.drug_strength.numerator_value
    IS 'The numeric value associated with the concentration of the active ingredient contained in the product';

COMMENT ON COLUMN vocabularies.drug_strength.numerator_unit_concept_id
    IS 'A foreign key to the Concept in the CONCEPT table representing the identifier for the numerator Unit for the concentration of active ingredient.';

COMMENT ON COLUMN vocabularies.drug_strength.denominator_value
    IS 'The amount of total liquid (or other divisible product, such as ointment, gel, spray, etc.).';

COMMENT ON COLUMN vocabularies.drug_strength.denominator_unit_concept_id
    IS 'A foreign key to the Concept in the CONCEPT table representing the identifier for the denominator Unit for the concentration of active ingredient.';

COMMENT ON COLUMN vocabularies.drug_strength.box_size
    IS 'The number of units of Clinical of Branded Drug, or Quantified Clinical or Branded Drug contained in a box as dispensed to the patient';

COMMENT ON COLUMN vocabularies.drug_strength.valid_start_date
    IS 'The date when the Concept was first recorded. The default value is 1-Jan-1970.';

COMMENT ON COLUMN vocabularies.drug_strength.valid_end_date
    IS 'The date when the concept became invalid because it was deleted or superseded (updated) by a new Concept. The default value is 31-Dec-2099.';

COMMENT ON COLUMN vocabularies.drug_strength.invalid_reason
    IS 'Reason the concept was invalidated. Possible values are ''D'' (deleted), ''U'' (replaced with an update) or NULL when valid_end_date has the default value.';

GO

//// CHANGE name=change3
CREATE INDEX IF NOT EXISTS idx_drug_strength_ingredient_concept_id
    ON vocabularies.drug_strength USING btree
    (ingredient_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change4
CREATE INDEX IF NOT EXISTS idx_drug_strength_amount_unit_concept_id
    ON vocabularies.drug_strength USING btree
    (amount_unit_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change5
CREATE INDEX IF NOT EXISTS idx_drug_strength_numerator_unit_concept_id
    ON vocabularies.drug_strength USING btree
    (numerator_unit_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO

//// CHANGE name=change6
CREATE INDEX IF NOT EXISTS idx_drug_strength_denominator_unit_concept_id
    ON vocabularies.drug_strength USING btree
    (denominator_unit_concept_id ASC NULLS LAST)
    TABLESPACE pg_default;

GO
