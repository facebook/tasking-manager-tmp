import { RoadIcon, HomeIcon, WavesIcon, TaskIcon, AsteriskIcon } from '../svgIcons';
import { MappingTypes } from '../mappingTypes';
import { createComponentWithIntl } from '../../utils/testWithIntl';

test('test if MappingTypes with BUILDINGS option returns the correct icon', () => {
  const element = createComponentWithIntl(
    <MappingTypes types={['BUILDINGS']} colorClass={'blue'} />,
  );
  const testInstance = element.root;
  expect(testInstance.findByType(HomeIcon).props.className).toBe('ml1 mr3 blue');
  expect(testInstance.findByType(HomeIcon).props.height).toBe('23');
});

test('test if MappingTypes with ROADS and WATERWAYS option returns the correct icon', () => {
  const element = createComponentWithIntl(
    <MappingTypes types={['ROADS', 'WATERWAYS']} colorClass={'blue'} />,
  );
  const testInstance = element.root;
  expect(testInstance.findByType(RoadIcon).props.className).toBe('ml1 mr3 blue');
  expect(testInstance.findByType(WavesIcon).props.className).toBe('ml1 mr3 blue');
  expect(testInstance.findByType(HomeIcon).props.className).toBe('ml1 mr3 grey-light');
  expect(testInstance.findByType(TaskIcon).props.className).toBe('ml1 mr3 grey-light');
  const titles = testInstance.findAllByType('span').map((i) => i.props.title);
  expect(titles).toContain('Roads');
  expect(titles).toContain('Buildings');
  expect(titles).toContain('Land use');
  expect(titles).toContain('Waterways');
  expect(titles).toContain('Other');
});

test('test if MappingTypes with LAND_USE option returns the correct icon color', () => {
  const element = createComponentWithIntl(<MappingTypes types={['LAND_USE']} colorClass={'primary'} />);
  const testInstance = element.root;
  expect(testInstance.findByType(TaskIcon).props.className).toBe('ml1 mr3 primary');
  expect(testInstance.findByType(HomeIcon).props.className).toBe('ml1 mr3 grey-light');
});

test('test if MappingTypes with OTHER option returns the correct icon color', () => {
  const element = createComponentWithIntl(<MappingTypes types={['OTHER']} colorClass={'primary'} />);
  const testInstance = element.root;
  expect(testInstance.findByType(AsteriskIcon).props.className).toBe('ml1 mr3 primary');
  expect(testInstance.findByType(HomeIcon).props.className).toBe('ml1 mr3 grey-light');
});

test('test if MappingTypes with empty array returns all icons in grey-light', () => {
  const element = createComponentWithIntl(<MappingTypes types={[]} colorClass="primary" />);
  const testInstance = element.root;
  expect(testInstance.findByType(RoadIcon).props.className).toBe('ml1 mr3 grey-light');
  expect(testInstance.findByType(WavesIcon).props.className).toBe('ml1 mr3 grey-light');
  expect(testInstance.findByType(HomeIcon).props.className).toBe('ml1 mr3 grey-light');
  expect(testInstance.findByType(TaskIcon).props.className).toBe('ml1 mr3 grey-light');
  expect(testInstance.findByType(AsteriskIcon).props.className).toBe('ml1 mr3 grey-light');
});

test('test if MappingTypes with all type options returns all icons in primary', () => {
  const element = createComponentWithIntl(
    <MappingTypes
      types={['ROADS', 'LAND_USE', 'BUILDINGS', 'WATERWAYS', 'OTHER']}
      colorClass="primary"
    />,
  );
  const testInstance = element.root;
  expect(testInstance.findByType(RoadIcon).props.className).toBe('ml1 mr3 primary');
  expect(testInstance.findByType(WavesIcon).props.className).toBe('ml1 mr3 primary');
  expect(testInstance.findByType(HomeIcon).props.className).toBe('ml1 mr3 primary');
  expect(testInstance.findByType(TaskIcon).props.className).toBe('ml1 mr3 primary');
  expect(testInstance.findByType(AsteriskIcon).props.className).toBe('ml1 mr3 primary');
});
