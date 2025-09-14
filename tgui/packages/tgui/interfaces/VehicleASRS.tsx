import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
import { Window } from '../layouts';

type VehicleASRSData = {
  status: 'Raised' | 'Lowered' | 'Moving' | 'Unavailable';
  has_elevator: boolean;
};

export const VehicleASRS = () => {
  const { act, data } = useBackend<VehicleASRSData>();

  return (
    <Window width={300} height={135}>
      <Window.Content>
        <Section title="Vehicle Elevator">
          <Box mb={1}>Platform position: {data.status}</Box>

          {data.has_elevator && data.status !== 'Moving' && (
            <>
              {data.status === 'Raised' && (
                <Button
                  icon="arrow-down"
                  content="Lower Elevator"
                  onClick={() => act('lower')}
                />
              )}
              {data.status === 'Lowered' && (
                <Button
                  icon="arrow-up"
                  content="Raise Elevator"
                  onClick={() => act('raise')}
                />
              )}
            </>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
