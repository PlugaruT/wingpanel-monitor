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

    public Indicator (Wingpanel.IndicatorManager.ServerType server_type) {
        Object (
            code_name: APPNAME,
            display_name: "Wingpanel-Monitor",
            description: "System monitor indicator for Wingpanel"
            );

        visible = true;
    }

    public override Gtk.Widget get_display_widget () {
        if (display_widget == null) {
            display_widget = new DisplayWidget();
        }
        return display_widget;
    }

    public override Gtk.Widget ? get_widget () {
        if (popover_widget == null) {
            popover_widget = null;
        }

        return popover_widget;
    }

    public override void opened () {
    }

    public override void closed () {
    }
}

public Wingpanel.Indicator ? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    debug ("Loading system monitor indicator");

    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        debug ("Wingpanel is not in session, not loading sys-monitor");
        return null;
    }

    var indicator = new WingpanelMonitor.Indicator (server_type);

    return indicator;
}
