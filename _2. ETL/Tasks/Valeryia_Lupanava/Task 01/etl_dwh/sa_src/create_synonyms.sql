-- Synonyms for giving others.

BEGIN
  pkg_synonyms.create_syn_pub(schema_name => 'SA_SRC_LAB', object_name => 'EXT_COUNTRIES', synonym_name => 'SA_CN');
END;

BEGIN
  pkg_synonyms.create_syn_pub(schema_name => 'SA_SRC_LAB', object_name => 'EXT_STRUCTURES', synonym_name => 'SA_CS');
END;

BEGIN
  pkg_synonyms.create_syn_pub(schema_name => 'SA_SRC_LAB', object_name => 'EXT_FULL_DATA', synonym_name => 'SA_FD');
END;

-- Synonyms for giving grants.

BEGIN
  pkg_synonyms.create_syn_priv(schema_name => 'SA_SRC_LAB', object_name => 'EXT_COUNTRIES', synonym_name => 'SA_CN');
END;

BEGIN
  pkg_synonyms.create_syn_priv(schema_name => 'SA_SRC_LAB', object_name => 'EXT_STRUCTURES', synonym_name => 'SA_CS');
END;

BEGIN
  pkg_synonyms.create_syn_priv(schema_name => 'SA_SRC_LAB', object_name => 'EXT_FULL_DATA', synonym_name => 'SA_FD');
END;