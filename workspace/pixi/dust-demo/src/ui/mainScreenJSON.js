export default {
	id: 'mainScreen',
	component: 'Window',	
	padding: 4,
	position: { x: 0, y: 0 },
	width: 600,
	height: 500,

	layout: [1, 4],
	children: [
        {
            id: 'label1',
            text: 'My Awesome Game',
            font: {
                size: '50px',
                family: 'Skranji',
                color: '#8f8'
            },
            component: 'Label',
            position: 'center',
            width: 600,
            height: 80
        },
		{
		  id: 'playBtn',
		  text: 'Play',
		  component: 'Button',
		  position: 'center',
		  
		  width: 190,
		  height: 80
		},
		{
		  id: 'optionsBtn',
		  text: 'Options',
		  component: 'Button',
		  position: 'center',
		  width: 190,
		  height: 80
		}		
	]
}