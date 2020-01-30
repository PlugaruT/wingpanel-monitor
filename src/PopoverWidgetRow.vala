/*-
 * Copyright (c) 2020 Tudor Plugaru (https://github.com/PlugaruT/wingpanel-monitor)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 *
 * Authored by: Tudor Plugaru <plugaru.tudor@gmail.com>
 */

public class WingpanelMonitor.PopoverWidgetRow : Gtk.Grid {
    private Gtk.Label text_label;
    private Gtk.Label value_label;

    public string label_value {
        set { value_label.label = value; }
    }

    public PopoverWidgetRow (string text, string val="", int char_width) {
        hexpand = true;
        margin_start = 6;

        text_label = new Gtk.Label (text);
        text_label.halign = Gtk.Align.START;
        text_label.hexpand = true;
        text_label.margin_start = 9;
        text_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);

        value_label = new Gtk.Label (val);
        value_label.halign = Gtk.Align.END;
        value_label.set_width_chars (char_width);
        value_label.set_justify (Gtk.Justification.FILL);
        value_label.margin_end = 9;

        add (text_label);
        add (value_label);
    }
}

