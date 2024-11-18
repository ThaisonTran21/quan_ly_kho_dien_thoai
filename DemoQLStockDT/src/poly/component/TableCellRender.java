/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.component;

import java.awt.Color;
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

/**
 *
 * @author user
 */
public class TableCellRender extends DefaultTableCellRenderer{

    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
       Component com = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column); 
       FunctionCell fc = new FunctionCell();
       if(isSelected == false && row % 2 == 0){
           fc.setBackground(Color.WHITE);
       }else{
           fc.setBackground(com.getBackground());
       }
       
       return fc;
    }
    
}
