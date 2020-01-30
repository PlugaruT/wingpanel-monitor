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

public class WingpanelMonitor.Indicator : Wingpanel.Indicator {
    const string APPNAME = "wingpanel-monitor";

    private DisplayWidget display_widget;
    private PopoverWidget popover_widget;

    private CPU cpu_data;
    private Memory memory_data;
    private Network network_data;
    private System system_data;

    private static GLib.Settings settings;

    public Indicator (Wingpanel.IndicatorManager.ServerType server_type) {
        Object (
            code_name: APPNAME,
            display_name: "Wingpanel-Monitor",
            description: "System monitor indicator for Wingpanel"
            );
    }

    construct {
        cpu_data = new CPU ();
        memory_data = new Memory ();
        network_data = new Network ();
        system_data = new System ();

        settings = new GLib.Settings ("com.github.plugarut.wingpanel-monitor");

        visible = settings.get_boolean("display-indicator");

        settings.bind ("display-indicator", this, "visible", SettingsBindFlags.DEFAULT);
    }

    public override Gtk.Widget get_display_widget () {
        if (display_widget == null) {
            display_widget = new DisplayWidget ();
            update_display_widget_data ();
        }
        return display_widget;
    }

    public override Gtk.Widget ? get_widget () {
        if (popover_widget == null) {
            popover_widget = new PopoverWidget (settings);
        }

        return popover_widget;
    }

    public override void opened () {
    }

    public override void closed () {
    }

    private void update_display_widget_data () {
        if (display_widget != null) {
            Timeout.add_seconds (1, () => {
                display_widget.update_cpu (cpu_data.percentage_used);
                display_widget.update_memory (memory_data.percentage_used);
                var net = network_data.get_bytes ();
                display_widget.update_network (net[0], net[1]);

                update_popover_widget_data ();
                return true;
            });
        }
    }

    private void update_popover_widget_data () {
        if (popover_widget == null) return;
        popover_widget.update_cpu_frequency (cpu_data.frequency);
        popover_widget.update_uptime (system_data.uptime);
        var net = network_data.get_bytes ();
        popover_widget.update_network (net[0], net[1]);
    }
}

public Wingpanel.Indicator ? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    debug ("Loading system monitor indicator");

    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        debug ("Wingpanel is not in session, not loading wingpanel-monitor indicator");
        return null;
    }

    var indicator = new WingpanelMonitor.Indicator (server_type);

    return indicator;
}
