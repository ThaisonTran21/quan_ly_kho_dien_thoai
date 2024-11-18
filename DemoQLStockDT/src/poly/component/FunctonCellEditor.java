/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.component;

import java.awt.Component;
import javax.swing.DefaultCellEditor;
import javax.swing.JCheckBox;
import javax.swing.JTable;

/**
 *
 * @author user
 */
public class FunctonCellEditor extends DefaultCellEditor{

    private TableActionEvent event;
    public FunctonCellEditor(TableActionEvent event) {
        super(new JCheckBox());
        this.event = event;
    }

    @Override
    public Component getTableCellEditorComponent(JTable table, Object value, boolean isSelected, int row, int column) {
        FunctionCell fc = new FunctionCell();
        fc.initEvent(event, row);
        fc.setBackground(table.getBackground());
        return fc;
    }
    
}
