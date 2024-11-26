import 'package:pokedex_app/models/poke_api_model.dart';
import 'package:pokedex_app/utils/constants.dart';

class Pokemon {
  final String name;
  final String url;

  final int id;
  final String imageUrl;
  bool isFav;

  final int? baseExperience;
  final int? height;
  final int? weight;
  final bool? isDefault;
  final int? order;
  final List<PokemonAbility>? abilities;
  final List<PokemonForm>? forms;
  final List<GameIndex>? gameIndices;
  final List<PokemonHeldItem>? heldItems;
  final String? locationAreaEncounters;
  final List<PokemonMove>? moves;
  final PokemonSprites? sprites;
  final List<PokemonStat>? stats;
  final List<PokemonType>? types;

  Pokemon({
    required this.name,
    required this.url,
    required this.id,
    required this.imageUrl,
    this.isFav = false,
    this.baseExperience,
    this.height,
    this.weight,
    this.isDefault,
    this.order,
    this.abilities,
    this.forms,
    this.gameIndices,
    this.heldItems,
    this.locationAreaEncounters,
    this.moves,
    this.sprites,
    this.stats,
    this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final url = json['url'];
    final regex = RegExp(r'/(\d+)/?$');
    final match = regex.firstMatch(url);
    final id = int.parse(match?.group(1) ?? '0');

    return Pokemon(
      name: json['name'],
      url: url,
      id: id,
      isFav: json['isFav'] ?? false,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }

  factory Pokemon.fromDetailJson(Map<String, dynamic> json) {
    final id = json['id'];
    return Pokemon(
      name: json['name'],
      isFav: json['isFav'] ?? false,
      url: ApiConstants.baseUri +
          ApiConstants.pokemonDetailsByNumberOrName +
          id.toString(),
      id: id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      isDefault: json['is_default'],
      order: json['order'],
      abilities: (json['abilities'] as List?)
          ?.map((item) => PokemonAbility.fromJson(item))
          .toList(),
      forms: (json['forms'] as List?)
          ?.map((item) => PokemonForm.fromJson(item))
          .toList(),
      gameIndices: (json['game_indices'] as List?)
          ?.map((item) => GameIndex.fromJson(item))
          .toList(),
      heldItems: (json['held_items'] as List?)
          ?.map((item) => PokemonHeldItem.fromJson(item))
          .toList(),
      locationAreaEncounters: json['location_area_encounters'],
      moves: (json['moves'] as List?)
          ?.map((item) => PokemonMove.fromJson(item))
          .toList(),
      sprites: json['sprites'] != null
          ? PokemonSprites.fromJson(json['sprites'])
          : null,
      stats: (json['stats'] as List?)
          ?.map((item) => PokemonStat.fromJson(item))
          .toList(),
      types: (json['types'] as List?)
          ?.map((item) => PokemonType.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'id': id,
      'imageUrl': imageUrl,
      'isFav': isFav,
    };
  }

  Pokemon copyWith({
    String? name,
    String? url,
    int? id,
    String? imageUrl,
    bool? isFav,
    int? baseExperience,
    int? height,
    int? weight,
    bool? isDefault,
    int? order,
    List<PokemonAbility>? abilities,
    List<PokemonForm>? forms,
    List<GameIndex>? gameIndices,
    List<PokemonHeldItem>? heldItems,
    String? locationAreaEncounters,
    List<PokemonMove>? moves,
    PokemonSprites? sprites,
    List<PokemonStat>? stats,
    List<PokemonType>? types,
  }) {
    return Pokemon(
      name: name ?? this.name,
      url: url ?? this.url,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      isFav: isFav ?? this.isFav,
      baseExperience: baseExperience ?? this.baseExperience,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isDefault: isDefault ?? this.isDefault,
      order: order ?? this.order,
      abilities: abilities ?? this.abilities,
      forms: forms ?? this.forms,
      gameIndices: gameIndices ?? this.gameIndices,
      heldItems: heldItems ?? this.heldItems,
      locationAreaEncounters:
          locationAreaEncounters ?? this.locationAreaEncounters,
      moves: moves ?? this.moves,
      sprites: sprites ?? this.sprites,
      stats: stats ?? this.stats,
      types: types ?? this.types,
    );
  }
}

class PokemonAbility {
  final bool isHidden;
  final int slot;
  final NamedAPIResource ability;

  PokemonAbility({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      isHidden: json['is_hidden'],
      slot: json['slot'],
      ability: NamedAPIResource.fromJson(json['ability']),
    );
  }
}

class PokemonForm {
  final String name;
  final String url;

  PokemonForm({
    required this.name,
    required this.url,
  });

  factory PokemonForm.fromJson(Map<String, dynamic> json) {
    return PokemonForm(
      name: json['name'],
      url: json['url'],
    );
  }
}

class PokemonFormSprites {
  final String? backDefault;
  final String? backShiny;
  final String? frontDefault;
  final String? frontShiny;

  PokemonFormSprites({
    required this.backDefault,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
  });

  factory PokemonFormSprites.fromJson(Map<String, dynamic> json) {
    return PokemonFormSprites(
      backDefault: json['back_default'] ?? '',
      backShiny: json['back_shiny'] ?? '',
      frontDefault: json['front_default'] ?? '',
      frontShiny: json['front_shiny'] ?? '',
    );
  }
}

class GameIndex {
  final int gameIndex;
  final NamedAPIResource version;

  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  factory GameIndex.fromJson(Map<String, dynamic> json) {
    return GameIndex(
      gameIndex: json['game_index'],
      version: NamedAPIResource.fromJson(json['version']),
    );
  }
}

class PokemonHeldItem {
  final NamedAPIResource item;
  final List<VersionDetail> versionDetails;

  PokemonHeldItem({
    required this.item,
    required this.versionDetails,
  });

  factory PokemonHeldItem.fromJson(Map<String, dynamic> json) {
    return PokemonHeldItem(
      item: NamedAPIResource.fromJson(json['item']),
      versionDetails: (json['version_details'] as List)
          .map((item) => VersionDetail.fromJson(item))
          .toList(),
    );
  }
}

class VersionDetail {
  final int rarity;
  final NamedAPIResource version;

  VersionDetail({
    required this.rarity,
    required this.version,
  });

  factory VersionDetail.fromJson(Map<String, dynamic> json) {
    return VersionDetail(
      rarity: json['rarity'],
      version: NamedAPIResource.fromJson(json['version']),
    );
  }
}

class PokemonMove {
  final NamedAPIResource move;
  final List<VersionGroupDetail> versionGroupDetails;

  PokemonMove({
    required this.move,
    required this.versionGroupDetails,
  });

  factory PokemonMove.fromJson(Map<String, dynamic> json) {
    return PokemonMove(
      move: NamedAPIResource.fromJson(json['move']),
      versionGroupDetails: (json['version_group_details'] as List)
          .map((item) => VersionGroupDetail.fromJson(item))
          .toList(),
    );
  }
}

class VersionGroupDetail {
  final int levelLearnedAt;
  final NamedAPIResource moveLearnMethod;
  final NamedAPIResource versionGroup;

  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) {
    return VersionGroupDetail(
      levelLearnedAt: json['level_learned_at'],
      moveLearnMethod: NamedAPIResource.fromJson(json['move_learn_method']),
      versionGroup: NamedAPIResource.fromJson(json['version_group']),
    );
  }
}

class PokemonSprites {
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;
  final Other? other;
  // final Versions? versions;

  PokemonSprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.other,
    // this.versions,
  });

  factory PokemonSprites.fromJson(Map<String, dynamic> json) {
    return PokemonSprites(
      backDefault: json['back_default'],
      backFemale: json['back_female'],
      backShiny: json['back_shiny'],
      backShinyFemale: json['back_shiny_female'],
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
      other: json['other'] != null ? Other.fromJson(json['other']) : null,
      // versions:
      //     json['versions'] != null ? Versions.fromJson(json['versions']) : null,
    );
  }
}

class Other {
  final DreamWorld? dreamWorld;
  final Home? home;
  final OfficialArtwork? officialArtwork;

  Other({
    this.dreamWorld,
    this.home,
    this.officialArtwork,
  });

  factory Other.fromJson(Map<String, dynamic> json) {
    return Other(
      dreamWorld: json['dream_world'] != null
          ? DreamWorld.fromJson(json['dream_world'])
          : null,
      home: json['home'] != null ? Home.fromJson(json['home']) : null,
      officialArtwork: json['official-artwork'] != null
          ? OfficialArtwork.fromJson(json['official-artwork'])
          : null,
    );
  }
}

class DreamWorld {
  final String? frontDefault;
  final String? frontFemale;

  DreamWorld({
    this.frontDefault,
    this.frontFemale,
  });

  factory DreamWorld.fromJson(Map<String, dynamic> json) {
    return DreamWorld(
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
    );
  }
}

class Home {
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  Home({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
    );
  }
}

class OfficialArtwork {
  final String? frontDefault;
  final String? frontShiny;

  OfficialArtwork({
    this.frontDefault,
    this.frontShiny,
  });

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) {
    return OfficialArtwork(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
    );
  }
}
