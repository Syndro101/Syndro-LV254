import type { BooleanLike } from 'common/react';
import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import {
  Button,
  Collapsible,
  Divider,
  Flex,
  Input,
  LabeledList,
  Section,
} from 'tgui/components';
import { Window } from 'tgui/layouts';

interface CategoryItem {
  name: string;
  desc: string;
  cost: number;
  path: string;
}

interface Data {
  busy?: BooleanLike;
  selected_vehicle?: string;
  points?: number;
  BuildQueue?: { name: string; cost: number; index: number }[];
  'Primary Weapons'?: CategoryItem[];
  'Primary Ammunition'?: CategoryItem[];
  'Secondary Weapons'?: CategoryItem[];
  'Secondary Ammunition'?: CategoryItem[];
  'Support Modules'?: CategoryItem[];
}

export const PartFabricatorVehicle = (props, context) => {
  const { act, data } = useBackend<Data>();
  const selected = data.selected_vehicle;
  const [search, setSearch] = useState('');

  // Helper to style selected vehicle buttons
  const selectedStyle = (key: string) =>
    selected === key
      ? { backgroundColor: '#28a745', color: 'white' }
      : undefined;

  const categories = [
    'Primary Weapons',
    'Primary Ammunition',
    'Secondary Weapons',
    'Secondary Ammunition',
    'Support Modules',
  ];

  // Normalize search query
  const query = search.toLowerCase();

  return (
    <Window width={950} height={825}>
      <Window.Content>
        <Flex direction="row" grow={1}>
          {/* Left Column: Vehicle selection + build queue */}
          <Flex.Item basis="34%" grow={0} mr={1}>
            <Section title="Vehicles">
              <Flex direction="column" gap={1}>
                {['jeep', 'arc', 'apc', 'lav', 'longstreet'].map((veh) => (
                  <Button
                    key={veh}
                    fluid
                    disabled={data.busy}
                    onClick={() => act('select_vehicle', { vehicle: veh })}
                    style={{
                      height: '64px',
                      fontSize: '18px',
                      lineHeight: '64px',
                      textAlign: 'center',
                      ...selectedStyle(veh),
                    }}
                  >
                    {veh.toUpperCase()}
                  </Button>
                ))}
              </Flex>
            </Section>

            {/* Scrollable Build Queue */}
            <Section title="Build Queue" scrollable fill>
              {data.BuildQueue?.length ? (
                data.BuildQueue.map((entry) => (
                  <Flex key={entry.index} justify="space-between" mb={1}>
                    <span>
                      {entry.name} ({entry.cost})
                    </span>
                    <Button
                      icon="times"
                      disabled={data.busy && entry.index === 1}
                      onClick={() => act('cancel', { index: entry.index })}
                    />
                  </Flex>
                ))
              ) : (
                <span>No items queued</span>
              )}
            </Section>
          </Flex.Item>

          {/* Vertical divider */}
          <Divider vertical />

          {/* Right Column: Points + Scrollable Categories */}
          <Flex.Item basis="66%" grow={1} ml={1}>
            <Section title="Fabricator Status">
              <b>Available Points:</b> {data.points ?? 0}
            </Section>

            <Section title="Categories" scrollable fill>
              {/* Search bar */}
              <Input
                fluid
                placeholder="Search items..."
                value={search}
                onInput={(e, value) => setSearch(value)}
                mb={2}
              />

              {categories.map((cat) => {
                const items = data[cat] || [];
                // Filter items by search query
                const filtered = items.filter(
                  (item) =>
                    item.name.toLowerCase().includes(query) ||
                    item.desc.toLowerCase().includes(query),
                );

                return (
                  <Collapsible key={cat} title={cat}>
                    {filtered.length ? (
                      <LabeledList>
                        {filtered.map((item, i) => (
                          <LabeledList.Item
                            key={i}
                            label={item.name}
                            className="underline"
                            buttons={
                              <Button
                                icon="wrench"
                                tooltip={item.desc}
                                tooltipPosition="left"
                                disabled={data.busy || !selected}
                                onClick={() =>
                                  act('produce', {
                                    category: cat,
                                    index: i + 1,
                                  })
                                }
                              >
                                {`Fabricate (${item.cost})`}
                              </Button>
                            }
                          />
                        ))}
                      </LabeledList>
                    ) : (
                      <span>No matching items</span>
                    )}
                  </Collapsible>
                );
              })}
            </Section>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
