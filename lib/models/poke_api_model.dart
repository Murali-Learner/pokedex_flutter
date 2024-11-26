import 'package:pokedex_app/models/pokemon_model.dart';

class PokemonListModel {
  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;

  PokemonListModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((item) => Pokemon.fromJson(item))
          .toList(),
    );
  }
}

// class Versions {
//   final GenerationI? generationI;
//   final GenerationIi? generationIi;
//   final GenerationIii? generationIii;
//   final GenerationIv? generationIv;
//   final GenerationV? generationV;
//   final GenerationVi? generationVi;
//   final GenerationVii? generationVii;
//   final GenerationViii? generationViii;

//   Versions({
//     this.generationI,
//     this.generationIi,
//     this.generationIii,
//     this.generationIv,
//     this.generationV,
//     this.generationVi,
//     this.generationVii,
//     this.generationViii,
//   });

//   factory Versions.fromJson(Map<String, dynamic> json) {
//     return Versions(
//       generationI: json['generation-i'] != null
//           ? GenerationI.fromJson(json['generation-i'])
//           : null,
//       generationIi: json['generation-ii'] != null
//           ? GenerationIi.fromJson(json['generation-ii'])
//           : null,
//       generationIii: json['generation-iii'] != null
//           ? GenerationIii.fromJson(json['generation-iii'])
//           : null,
//       generationIv: json['generation-iv'] != null
//           ? GenerationIv.fromJson(json['generation-iv'])
//           : null,
//       generationV: json['generation-v'] != null
//           ? GenerationV.fromJson(json['generation-v'])
//           : null,
//       generationVi: json['generation-vi'] != null
//           ? GenerationVi.fromJson(json['generation-vi'])
//           : null,
//       generationVii: json['generation-vii'] != null
//           ? GenerationVii.fromJson(json['generation-vii'])
//           : null,
//       generationViii: json['generation-viii'] != null
//           ? GenerationViii.fromJson(json['generation-viii'])
//           : null,
//     );
//   }
// }

class PokemonStat {
  final int baseStat;
  final int effort;
  final NamedAPIResource stat;

  PokemonStat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: NamedAPIResource.fromJson(json['stat']),
    );
  }
}

class PokemonType {
  final int slot;
  final NamedAPIResource type;

  PokemonType({
    required this.slot,
    required this.type,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      slot: json['slot'],
      type: NamedAPIResource.fromJson(json['type']),
    );
  }
}

class NamedAPIResource {
  final String name;
  final String url;

  NamedAPIResource({
    required this.name,
    required this.url,
  });

  factory NamedAPIResource.fromJson(Map<String, dynamic> json) {
    return NamedAPIResource(
      name: json['name'],
      url: json['url'],
    );
  }
}
