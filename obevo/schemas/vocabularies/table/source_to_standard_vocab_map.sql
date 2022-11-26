//// CHANGE name=change0

create table if not exists vocabularies.source_to_standard_vocab_map(
  source_concept_id int,
  target_concept_id int
    references vocabularies.concept(concept_id) on update cascade deferrable,
  source_valid_start_date date,
  source_valid_end_date date,
  source_code text,
  source_code_description text,
  source_vocabulary_id text,
  source_domain_id text
    references vocabularies.domain(domain_id) on update cascade deferrable,
  source_concept_class_id text
    references vocabularies.concept_class(concept_class_id) on update cascade deferrable,
  source_invalid_reason text,
  target_concept_name text,
  target_vocabulary_id text
    references vocabularies.vocabulary(vocabulary_id) on update cascade deferrable,
  target_domain_id text,
  target_concept_class_id text
    references vocabularies.concept_class(concept_class_id) on update cascade deferrable,
  target_invalid_reason text,
  target_standard_concept text
);


//// CHANGE name=change2

create index on vocabularies.source_to_standard_vocab_map(source_code);
create index on vocabularies.source_to_standard_vocab_map(target_concept_id);

GO
