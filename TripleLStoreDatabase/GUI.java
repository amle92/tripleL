import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class GUI
{
	public static void main(String[]args)
	{
		final JFrame myFrame = new JFrame();
		
		final JTextField tableText = new JTextField();
		tableText.setText("TableNameHere");
		final JTextField queryText = new JTextField();
		queryText.setText("QueryNameHere");

		final JButton insertButton = new JButton("Insert");
		final JButton selectButton = new JButton("Select");
		final JButton deleteButton = new JButton("Delete");
		
		final JPanel panel = new JPanel();
		panel.add(insertButton);
		panel.add(selectButton);
		panel.add(deleteButton);
		
		insertButton.addActionListener(new ActionListener()
		{
			@Override
			public void actionPerformed(ActionEvent e)
			{
				
			}
		});
		
		selectButton.addActionListener(new ActionListener()
		{

			@Override
			public void actionPerformed(ActionEvent e)
			{
				
			}
			
		});
		
		deleteButton.addActionListener(new ActionListener()
		{
			@Override
			public void actionPerformed(ActionEvent arg0)
			{
			}
		});
		
		myFrame.add(tableText, BorderLayout.NORTH);
		myFrame.add(queryText, BorderLayout.NORTH);
		myFrame.add(panel, BorderLayout.CENTER);
		
		myFrame.pack();
		myFrame.setLayout(new BorderLayout());
		myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		myFrame.setVisible(true);
		
		
	}
	
}
