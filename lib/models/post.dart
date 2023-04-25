// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.meta,
    required this.results,
  });

  Meta meta;
  List<Result> results;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    meta: Meta.fromJson(json["meta"]),
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Meta {
  Meta({
    required this.disclaimer,
    required this.terms,
    required this.license,
    required this.lastUpdated,
    required this.results,
  });

  String disclaimer;
  String terms;
  String license;
  DateTime lastUpdated;
  Results results;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    disclaimer: json["disclaimer"],
    terms: json["terms"],
    license: json["license"],
    lastUpdated: DateTime.parse(json["last_updated"]),
    results: Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "disclaimer": disclaimer,
    "terms": terms,
    "license": license,
    "last_updated": "${lastUpdated.year.toString().padLeft(4, '0')}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')}",
    "results": results.toJson(),
  };
}

class Results {
  Results({
    required this.skip,
    required this.limit,
    required this.total,
  });

  int skip;
  int limit;
  int total;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    skip: json["skip"],
    limit: json["limit"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "skip": skip,
    "limit": limit,
    "total": total,
  };
}

class Result {
  Result({

    required this.splProductDataElements,
    required this.recentMajorChanges,
    required this.indicationsAndUsage,
    required this.dosageAndAdministration,
    required this.dosageAndAdministrationTable,
    required this.dosageFormsAndStrengths,
    required this.contraindications,
    required this.warningsAndCautions,
    required this.adverseReactions,
    required this.drugInteractions,
    required this.drugInteractionsTable,
    required this.useInSpecificPopulations,
    required this.pregnancy,
    required this.laborAndDelivery,
    required this.pediatricUse,
    required this.geriatricUse,
    required this.overdosage,
    required this.description,
    required this.clinicalPharmacology,
    required this.clinicalPharmacologyTable,
    required this.mechanismOfAction,
    required this.pharmacodynamics,
    required this.pharmacodynamicsTable,
    required this.pharmacokinetics,
    required this.pharmacokineticsTable,
    required this.nonclinicalToxicology,
    required this.carcinogenesisAndMutagenesisAndImpairmentOfFertility,
    required this.animalPharmacologyAndOrToxicology,
    required this.clinicalStudies,
    required this.clinicalStudiesTable,
    required this.howSupplied,
    required this.informationForPatients,
    required this.splMedguide,
    required this.splUnclassifiedSection,
    required this.packageLabelPrincipalDisplayPanel,
    required this.setId,
    required this.id,
    required this.effectiveTime,
    required this.version,
    required this.openfda,
  });

  List<String> splProductDataElements;
  List<String>? recentMajorChanges;
  List<String> indicationsAndUsage;
  List<String> dosageAndAdministration;
  List<String> dosageAndAdministrationTable;
  List<String> dosageFormsAndStrengths;
  List<String> contraindications;
  List<String> warningsAndCautions;
  List<String> adverseReactions;
  List<String> drugInteractions;
  List<String> drugInteractionsTable;
  List<String> useInSpecificPopulations;
  List<String> pregnancy;
  List<String> laborAndDelivery;
  List<String> pediatricUse;
  List<String> geriatricUse;
  List<String> overdosage;
  List<String> description;
  List<String> clinicalPharmacology;
  List<String> clinicalPharmacologyTable;
  List<String> mechanismOfAction;
  List<String> pharmacodynamics;
  List<String> pharmacodynamicsTable;
  List<String> pharmacokinetics;
  List<String> pharmacokineticsTable;
  List<String> nonclinicalToxicology;
  List<String> carcinogenesisAndMutagenesisAndImpairmentOfFertility;
  List<String> animalPharmacologyAndOrToxicology;
  List<String> clinicalStudies;
  List<String> clinicalStudiesTable;
  List<String> howSupplied;
  List<String> informationForPatients;
  List<String> splMedguide;
  List<String> splUnclassifiedSection;
  List<String> packageLabelPrincipalDisplayPanel;
  String setId;
  String id;
  String effectiveTime;
  String version;
  Map<String, List<String>> openfda;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    splProductDataElements:json["spl_product_data_elements"] != null ? List<String>.from(json["spl_product_data_elements"].map((x) => x)) : <String>["no relevant information Found"],
    recentMajorChanges: json["recent_major_changes"] != null ?  List<String>.from( json["recent_major_changes"].map((x) => (x))) : <String>["no relevant information Found"],
    // recentMajorChanges: List<String>.from(json["recent_major_changes"].map((x) => x)),
    indicationsAndUsage:json["indications_and_usage"] != null ? List<String>.from(json["indications_and_usage"].map((x) => x)) : <String>["no relevant information Found"],
    dosageAndAdministration:json["dosage_and_administration"] != null ? List<String>.from(json["dosage_and_administration"].map((x) => x)) : <String>["no relevant information Found"],
    dosageAndAdministrationTable:json["dosage_and_administration_table"] != null ?  List<String>.from( json["dosage_and_administration_table"].map((x) => x)) : <String>["no relevant information Found"],
    dosageFormsAndStrengths:json["dosage_forms_and_strengths"] != null ? List<String>.from(json["dosage_forms_and_strengths"].map((x) => x)) : <String>["no relevant information Found"],
    contraindications:json["contraindications"] != null ? List<String>.from(json["contraindications"].map((x) => x)): <String>["no relevant information Found"],
    warningsAndCautions:json["warnings_and_cautions"] != null ? List<String>.from(json["warnings_and_cautions"].map((x) => x)): <String>["no relevant information Found"],
    adverseReactions:json["adverse_reactions"] != null ? List<String>.from(json["adverse_reactions"].map((x) => x)): <String>["no relevant information Found"],
    drugInteractions:json["drug_interactions"] != null ? List<String>.from(json["drug_interactions"].map((x) => x)): <String>["no relevant information Found"],
    drugInteractionsTable:json["drug_interactions_table"] != null ? List<String>.from(json["drug_interactions_table"].map((x) => x)): <String>["no relevant information Found"],
    useInSpecificPopulations:json["use_in_specific_populations"] != null ? List<String>.from(json["use_in_specific_populations"].map((x) => x)): <String>["no relevant information Found"],
    pregnancy:json["pregnancy"] != null ? List<String>.from(json["pregnancy"].map((x) => x)): <String>["no relevant information Found"],
    laborAndDelivery:json["labor_and_delivery"] != null ? List<String>.from(json["labor_and_delivery"].map((x) => x)): <String>["No Relevant Information Found"],
    pediatricUse:json["pediatric_use"] != null ? List<String>.from(json["pediatric_use"].map((x) => x)): <String>["no relevant information Found"],
    geriatricUse:json["geriatric_use"] != null ? List<String>.from(json["geriatric_use"].map((x) => x)): <String>["no relevant information Found"],
    overdosage:json["overdosage"] != null ? List<String>.from(json["overdosage"].map((x) => x)): <String>["no relevant information Found"],
    description:json["description"] != null ? List<String>.from(json["description"].map((x) => x)): <String>["no relevant information Found"],
    clinicalPharmacology:json["clinical_pharmacology"] != null ? List<String>.from(json["clinical_pharmacology"].map((x) => x)): <String>["no relevant information Found"],
    clinicalPharmacologyTable:json["clinical_pharmacology_table"] != null ? List<String>.from(json["clinical_pharmacology_table"].map((x) => x)) : <String>["no relevant information Found"],
    mechanismOfAction:json["mechanism_of_action"] != null ? List<String>.from(json["mechanism_of_action"].map((x) => x)): <String>["no relevant information Found"],
    pharmacodynamics: json["pharmacodynamics"] != null ? List<String>.from(json["pharmacodynamics"].map((x) => x)) : <String>["no relevant information Found"],
    pharmacodynamicsTable: json["pharmacodynamics_table"] != null ? List<String>.from(json["pharmacodynamics_table"].map((x) => x)): <String>["no relevant information Found"],
    pharmacokinetics:json["pharmacokinetics"] != null ?  List<String>.from(json["pharmacokinetics"].map((x) => x)): <String>["no relevant information Found"],
    pharmacokineticsTable:json["pharmacokinetics_table"] != null ?  List<String>.from(json["pharmacokinetics_table"].map((x) => x)): <String>["no relevant information Found"],
    nonclinicalToxicology:json["nonclinical_toxicology"] != null ?  List<String>.from(json["nonclinical_toxicology"].map((x) => x)): <String>["no relevant information Found"],
    carcinogenesisAndMutagenesisAndImpairmentOfFertility:json["carcinogenesis_and_mutagenesis_and_impairment_of_fertility"] != null ? List<String>.from(json["carcinogenesis_and_mutagenesis_and_impairment_of_fertility"].map((x) => x)): <String>["no relevant information Found"],
    animalPharmacologyAndOrToxicology: json["animal_pharmacology_and_or_toxicology"] != null ? List<String>.from(json["animal_pharmacology_and_or_toxicology"].map((x) => x)) : <String>["no relevant information Found"],
    clinicalStudies:json["clinical_studies"] != null ? List<String>.from(json["clinical_studies"].map((x) => x)): <String>["no relevant information Found"],
    clinicalStudiesTable:json["clinical_studies_table"] != null ? List<String>.from(json["clinical_studies_table"].map((x) => x)): <String>["no relevant information Found"],
    howSupplied:json["how_supplied"] != null ? List<String>.from(json["how_supplied"].map((x) => x)): <String>["no relevant information Found"],
    informationForPatients:json["information_for_patients"] != null ? List<String>.from(json["information_for_patients"].map((x) => x)): <String>["no relevant information Found"],
    splMedguide:json["spl_medguide"] != null ? List<String>.from(json["spl_medguide"].map((x) => x)) : <String>["no relevant information Found"] ,
    splUnclassifiedSection:json["spl_unclassified_section"] != null ? List<String>.from(json["spl_unclassified_section"].map((x) => x)): <String>["no relevant information Found"],
    packageLabelPrincipalDisplayPanel:json["package_label_principal_display_panel"] != null ? List<String>.from(json["package_label_principal_display_panel"].map((x) => x)): <String>["no relevant information Found"],
    setId: json["set_id"],
    id: json["id"],
    effectiveTime: json["effective_time"],
    version: json["version"],
    openfda: Map.from(json["openfda"]).map((k, v) => MapEntry<String, List<String>>(k, json["openfda"] != null ? List<String>.from(v.map((x) => x)): <String>[])),
  );

  Map<String, dynamic> toJson() => {
    "spl_product_data_elements": List<dynamic>.from(splProductDataElements.map((x) => x)),
    "recent_major_changes": List<dynamic>.from(recentMajorChanges!.map((x) => x)),
    "indications_and_usage": List<dynamic>.from(indicationsAndUsage.map((x) => x)),
    "dosage_and_administration": List<dynamic>.from(dosageAndAdministration.map((x) => x)),
    "dosage_and_administration_table": List<dynamic>.from(dosageAndAdministrationTable.map((x) => x)),
    "dosage_forms_and_strengths": List<dynamic>.from(dosageFormsAndStrengths.map((x) => x)),
    "contraindications": List<dynamic>.from(contraindications.map((x) => x)),
    "warnings_and_cautions": List<dynamic>.from(warningsAndCautions.map((x) => x)),
    "adverse_reactions": List<dynamic>.from(adverseReactions.map((x) => x)),
    "drug_interactions": List<dynamic>.from(drugInteractions.map((x) => x)),
    "drug_interactions_table": List<dynamic>.from(drugInteractionsTable.map((x) => x)),
    "use_in_specific_populations": List<dynamic>.from(useInSpecificPopulations.map((x) => x)),
    "pregnancy": List<dynamic>.from(pregnancy.map((x) => x)),
    "labor_and_delivery": List<dynamic>.from(laborAndDelivery.map((x) => x)),
    "pediatric_use": List<dynamic>.from(pediatricUse.map((x) => x)),
    "geriatric_use": List<dynamic>.from(geriatricUse.map((x) => x)),
    "overdosage": List<dynamic>.from(overdosage.map((x) => x)),
    "description": List<dynamic>.from(description.map((x) => x)),
    "clinical_pharmacology": List<dynamic>.from(clinicalPharmacology.map((x) => x)),
    "clinical_pharmacology_table": List<dynamic>.from(clinicalPharmacologyTable.map((x) => x)),
    "mechanism_of_action": List<dynamic>.from(mechanismOfAction.map((x) => x)),
    "pharmacodynamics": List<dynamic>.from(pharmacodynamics.map((x) => x)),
    "pharmacodynamics_table": List<dynamic>.from(pharmacodynamicsTable.map((x) => x)),
    "pharmacokinetics": List<dynamic>.from(pharmacokinetics.map((x) => x)),
    "pharmacokinetics_table": List<dynamic>.from(pharmacokineticsTable.map((x) => x)),
    "nonclinical_toxicology": List<dynamic>.from(nonclinicalToxicology.map((x) => x)),
    "carcinogenesis_and_mutagenesis_and_impairment_of_fertility": List<dynamic>.from(carcinogenesisAndMutagenesisAndImpairmentOfFertility.map((x) => x)),
    "animal_pharmacology_and_or_toxicology": List<dynamic>.from(animalPharmacologyAndOrToxicology.map((x) => x)),
    "clinical_studies": List<dynamic>.from(clinicalStudies.map((x) => x)),
    "clinical_studies_table": List<dynamic>.from(clinicalStudiesTable.map((x) => x)),
    "how_supplied": List<dynamic>.from(howSupplied.map((x) => x)),
    "information_for_patients": List<dynamic>.from(informationForPatients.map((x) => x)),
    "spl_medguide": List<dynamic>.from(splMedguide.map((x) => x)),
    "spl_unclassified_section": List<dynamic>.from(splUnclassifiedSection.map((x) => x)),
    "package_label_principal_display_panel": List<dynamic>.from(packageLabelPrincipalDisplayPanel.map((x) => x)),
    "set_id": setId,
    "id": id,
    "effective_time": effectiveTime,
    "version": version,
    "openfda": Map.from(openfda).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
  };
}











































