/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.component;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.geom.Ellipse2D;
import javax.swing.JButton;
import javax.swing.border.EmptyBorder;

/**
 *
 * @author user
 */
public class FunctionButton extends JButton{
    
    private boolean mousePress;

    public FunctionButton() {
        setContentAreaFilled(false);
        setBorder(new EmptyBorder(3, 3, 3, 3));
        
        addMouseListener(new MouseAdapter(){
            @Override
            public void mouseReleased(MouseEvent e) {
                mousePress = false;
            }

            @Override
            public void mousePressed(MouseEvent e) {
                mousePress = true;
            }
            
        });
    }

    @Override
    protected void paintComponent(Graphics g) {
        Graphics2D gd = (Graphics2D) g.create();
        gd.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        int with = getWidth();
        int height = getHeight();
        int size = Math.min(with, height);
        int x = (with -size) / 2;
        int y = (height - size) /2;
        
        if(mousePress){
            gd.setColor(new Color(158, 158, 158));
        }else{
            gd.setColor(new Color(199, 199, 199));
        }
        
        gd.fill(new Ellipse2D.Double(x, y, size, size));
        gd.dispose();
        super.paintComponent(g);
    }
    
    
}
