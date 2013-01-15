using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.User.Identity.IsAuthenticated) return;
        var role = CurrentUser.Role();
        if (role == "Admin"){
            AdminMenuItems();
        }
        else if (role == "Sales"){
            SalesMenuItems();
        }
        else if (role == "SalesSupervisor") {
            SalesSupervisorMenuItems();
        }
        else if (role == "UnderWriter"){
            UnderWriterMenuItems();
        }
    }

    protected void AdminMenuItems()
    {
        MenuItemCollection menuItems = NavigationMenu.Items;
        List<MenuItem> toRemoveItems = new List<MenuItem>();
        foreach (MenuItem menuItem in menuItems)
        {
            if (menuItem.Value == "Sales" || menuItem.Value == "UnderWriter" || menuItem.Value == "Visit")
            {
                toRemoveItems.Add(menuItem);
            }
        }
        DeleteMenuItems(menuItems, toRemoveItems);
    }

    protected void SalesSupervisorMenuItems()
    {
        MenuItemCollection menuItems = NavigationMenu.Items;
        List<MenuItem> toRemoveItems = new List<MenuItem>();
        foreach (MenuItem menuItem in menuItems)
        {
            if (menuItem.Text == "Users" || menuItem.Value == "UnderWriter" || menuItem.Value == "Admin")
            {
                toRemoveItems.Add(menuItem);
            }
        }
        DeleteMenuItems(menuItems, toRemoveItems);
    }

    protected void SalesMenuItems()
    {
        MenuItemCollection menuItems = NavigationMenu.Items;
        List<MenuItem> toRemoveItems = new List<MenuItem>();
        foreach (MenuItem menuItem in menuItems)
        {
            if (menuItem.Text == "Users" || menuItem.Value == "UnderWriter" || menuItem.Value == "Admin")
            {
                toRemoveItems.Add(menuItem);
            }
        }
        DeleteMenuItems(menuItems, toRemoveItems);
    }

    protected void UnderWriterMenuItems()
    {
        MenuItemCollection menuItems = NavigationMenu.Items;
        List<MenuItem> toRemoveItems = new List<MenuItem>();
        foreach (MenuItem menuItem in menuItems)
        {
            if (menuItem.Text == "Users" || menuItem.Value == "Sales" || menuItem.Value == "Admin" || menuItem.Value == "Visit")
            {
                toRemoveItems.Add(menuItem);
            }
        }
        DeleteMenuItems(menuItems, toRemoveItems);
    }

    protected void DeleteMenuItems(MenuItemCollection menuItems, List<MenuItem> toRemoveItems)
    {
        foreach (MenuItem menuItemx in toRemoveItems)
        {
            menuItems.Remove(menuItemx);
        }
    }
}
