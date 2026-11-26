import '../../data/models/game_models.dart';

const scenarioTemplates = <Scenario>[
  Scenario(
    id: 'million',
    title: 'A Million-Euro Morning',
    story:
        'You wake up tomorrow with €1 million. It is entirely yours, but the deal comes with one condition.',
    category: 'Life',
    decisions: [
      Decision(
        id: 'phone',
        text: 'Never use a phone again',
        consequence:
            'Your offline escape fascinates everyone, while the group chat becomes impossible to live without.',
      ),
      Decision(
        id: 'thoughts',
        text: 'Tell friends every thought',
        consequence:
            'Honesty spreads quickly, but even your smallest thoughts become headlines among the group.',
      ),
      Decision(
        id: 'meal',
        text: 'Eat only one meal forever',
        consequence:
            'The group invents increasingly elaborate ways to eat that single meal.',
      ),
      Decision(
        id: 'friend',
        text: 'Give half to a random friend',
        consequence:
            'Friendship suddenly becomes a lottery and nobody trusts random acts of generosity.',
      ),
    ],
  ),
  Scenario(
    id: 'time',
    title: 'The Extra Hour',
    story:
        'Every day gains one mysterious hour at 3:00 AM. It may be used normally, but only you remember what happens.',
    category: 'Time',
    decisions: [
      Decision(
        id: 'sleep',
        text: 'Sleep through it',
        consequence:
            'You wake refreshed, but your missing hour starts appearing in your dreams.',
      ),
      Decision(
        id: 'learn',
        text: 'Learn everything',
        consequence:
            'Knowledge arrives, along with rumors that you know everyone’s secrets.',
      ),
      Decision(
        id: 'money',
        text: 'Earn extra money',
        consequence:
            'Your secret shift makes you rich enough to buy time—but not peace.',
      ),
      Decision(
        id: 'explore',
        text: 'Explore the hidden hour',
        consequence:
            'The hour reveals a city that exists only while everyone else is asleep.',
      ),
    ],
  ),
  Scenario(
    id: 'memory',
    title: 'The Perfect Memory',
    story:
        'A scientist offers perfect recall, but there is no option to forget. What do you do?',
    category: 'Mind',
    decisions: [
      Decision(
        id: 'accept',
        text: 'Accept the memory',
        consequence:
            'Every detail becomes vivid, including things the group hoped you had forgotten.',
      ),
      Decision(
        id: 'work',
        text: 'Use it to solve mysteries',
        consequence:
            'You become legendary, yet every unsolved clue starts following you home.',
      ),
      Decision(
        id: 'archive',
        text: 'Create a public archive',
        consequence:
            'Your archive exposes an uncomfortable history of tiny, private decisions.',
      ),
      Decision(
        id: 'decline',
        text: 'Decline and stay human',
        consequence:
            'The scientist admits that forgetting is sometimes a kindness.',
      ),
    ],
  ),
  Scenario(
    id: 'island',
    title: 'The Final Island',
    story:
        'Your friends discover an island that appears once per century. A message says only one item may leave.',
    category: 'Adventure',
    decisions: [
      Decision(
        id: 'treasure',
        text: 'Bring back treasure',
        consequence:
            'The treasure grants one wish for whoever carries it across the tide.',
      ),
      Decision(
        id: 'cure',
        text: 'Bring back a cure',
        consequence:
            'The cure works, but only for the first illness nobody admits to having.',
      ),
      Decision(
        id: 'map',
        text: 'Bring back a map',
        consequence:
            'The map marks doors that should not exist in any of your houses.',
      ),
      Decision(
        id: 'story',
        text: 'Bring back the island’s story',
        consequence:
            'Its story becomes yours, and the island remembers every retelling.',
      ),
    ],
  ),
  Scenario(
    id: 'voice',
    title: 'The Voice of Truth',
    story:
        'Tomorrow, everyone will hear you say your next sincere sentence—and only your sincerest sentence.',
    category: 'Social',
    decisions: [
      Decision(
        id: 'praise',
        text: 'Say something kind',
        consequence:
            'Your kindness goes viral, but strangers believe it is a coded message.',
      ),
      Decision(
        id: 'secret',
        text: 'Reveal a secret',
        consequence: 'A single secret unlocks several larger ones.',
      ),
      Decision(
        id: 'lie',
        text: 'Try to say nothing',
        consequence:
            'Silence is interpreted as a confession by everyone listening.',
      ),
      Decision(
        id: 'future',
        text: 'Predict the future',
        consequence:
            'Your prediction becomes true because nobody can resist fulfilling it.',
      ),
    ],
  ),
];

final extraScenarioTemplates = List.generate(25, (index) {
  final ideas = [
    (
      'The City That Forgets',
      'A neighborhood forgets one harmless rule every week.',
      'Social',
    ),
    (
      'Cloud Nine Delivery',
      'A crate falls from the sky addressed to your group.',
      'Mystery',
    ),
    (
      'The Laughing Map',
      'A map changes roads whenever someone lies near it.',
      'Adventure',
    ),
    (
      'Borrowed Tomorrow',
      'A stranger asks to borrow one future memory.',
      'Time',
    ),
    (
      'The Last Live Show',
      'The city will perform one concert but only if rules are obeyed.',
      'Culture',
    ),
    (
      'Petition for the Moon',
      'The moon sends a formal request for a local representative.',
      'Cosmic',
    ),
    (
      'The Honest Door',
      'A door opens only when the truth is spoken in its vicinity.',
      'Mind',
    ),
    (
      'Reverse Ticket',
      'A train ticket sends its holder backward by one day.',
      'Travel',
    ),
    (
      'The Weather Account',
      'Every person receives a private weather forecast only they can change.',
      'Nature',
    ),
    (
      'Museum of Almost',
      'An exhibit contains objects you nearly chose in life.',
      'Mystery',
    ),
    (
      'The Quiet Festival',
      'One public festival is silent, yet every sound must be chosen elsewhere.',
      'Culture',
    ),
    (
      'Victory Clause',
      'Winning a small contest unlocks a consequence for everyone.',
      'Challenge',
    ),
    (
      'The Borrowed Spotlight',
      'Someone in the group becomes famous for one hour.',
      'Social',
    ),
    (
      'The Unfinished Recipe',
      'A family recipe appears on the table without its final ingredient.',
      'Life',
    ),
    (
      'The Honest Mirror',
      'A mirror reflects not appearance, but the next decision.',
      'Mind',
    ),
    (
      'Midnight Library Card',
      'A library lends moments instead of books.',
      'Fantasy',
    ),
    (
      'The Perfect Duplicate',
      'A machine makes a copy of one object each person chooses.',
      'Science',
    ),
    (
      'The Polite Storm',
      'A storm will pass only if it receives a convincing apology.',
      'Nature',
    ),
    (
      'One Free Rumor',
      'A rumor you choose will become true for exactly one day.',
      'Social',
    ),
    (
      'The Empty Seat',
      'An unknown guest arrives and sits in the seat reserved for the future.',
      'Mystery',
    ),
    (
      'The Upgrade Shop',
      'A market offers personality upgrades at a hidden cost.',
      'Life',
    ),
    (
      'The Red Button',
      'A button pauses the world for everyone except the holder.',
      'Chaos',
    ),
    (
      'The Kind Hostage',
      'A clock tower demands one cheerful lie to stop striking.',
      'Adventure',
    ),
    (
      'A Second Shadow',
      'Everyone wakes with a shadow that has a different history.',
      'Fantasy',
    ),
    (
      'The Final Round',
      'The game offers one more round with no guarantee of an ending.',
      'Meta',
    ),
  ][index];
  return Scenario(
    id: 'generated_$index',
    title: ideas.$1,
    story:
        '${ideas.$2} The group must make one choice before the chance disappears.',
    category: ideas.$3,
    decisions: [
      Decision(
        id: 'a_$index',
        text: 'Take the safest path',
        consequence:
            'The choice protects the group, but leaves a far stranger problem unresolved.',
      ),
      Decision(
        id: 'b_$index',
        text: 'Trust the unexpected stranger',
        consequence:
            'The stranger knows more than expected, and asks for one favor in return.',
      ),
      Decision(
        id: 'c_$index',
        text: 'Turn it into a shared experiment',
        consequence:
            'Everyone changes, but nobody remembers who proposed the experiment first.',
      ),
      Decision(
        id: 'd_$index',
        text: 'Risk everything for the truth',
        consequence:
            'The truth arrives in an inconvenient form and forces the next decision.',
      ),
    ],
  );
});

final allScenarios = <Scenario>[
  ...scenarioTemplates,
  ...extraScenarioTemplates,
];
