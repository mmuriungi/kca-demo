page 51222 "CAFE Food Item Card"
{
    Caption = 'Item Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Approve,Request Approval';
    RefreshOnActivate = true;
    SourceTable = Item;
    SourceTableView = WHERE("Item Category Code" = FILTER('Food'));

    layout
    {
        area(content)
        {
            group(Item)
            {
                Caption = 'Item';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the item.';

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a description of the item.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    Enabled = InventoryItemEditable;
                    Importance = Promoted;
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';

                    trigger OnAssistEdit()
                    begin
                        Rec.MODIFY(TRUE);
                        COMMIT;
                        IF PAGE.RUNMODAL(PAGE::"Adjust Inventory", Rec) = ACTION::LookupOK THEN
                            Rec.FIND;
                        CurrPage.UPDATE
                    end;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the unit in which the item is held in inventory.';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);
                        Rec.GET(Rec."No.");
                    end;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                }
                // field("Assembly BOM";"Assembly BOM")
                // {
                //     ToolTip = 'Indicates if the item is an assembly BOM.';
                // }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the category that the item belongs to.';

                    trigger OnValidate()
                    var
                        ItemAttributeManagement: Codeunit "Item Attribute Management";
                    begin
                        ItemAttributeManagement.InheritAttributesFromItemCategory(Rec, Rec."Item Category Code", xRec."Item Category Code");
                        //CurrPage.ItemAttributesFactbox.PAGE.LoadItemAttributesData("No.");
                        //EnableCostingControls;
                    end;
                }
                // field("Control Category"; Rec."Control Category")
                // {
                //     ToolTip = 'Specifies the value of the Control Category field.';
                //     ApplicationArea = All;
                // }
                field("Control Unit of Measure"; Rec."Control Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Control Unit of Measure field.';
                    ApplicationArea = All;
                }
                // field("Product Group Code";"Product Group Code")
                // {
                //     ToolTip = 'Contains a product group code associated with the item category.';
                //     Visible = false;
                // }
            }
            group("Price & Posting")
            {
                Caption = 'Price & Posting';
                field("Costing Method"; Rec."Costing Method")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies how the item''s cost flow is recorded and whether an actual or budgeted value is capitalized and used in the cost calculation.';

                    trigger OnValidate()
                    begin
                        //EnableCostingControls;
                    end;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PriceEditable;
                    Importance = Promoted;
                    ToolTip = 'Specifies the price for one unit of the item, in $.';
                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on sales document lines for this item should be shown with or without tax.';
                    Visible = UseVAT;

                    trigger OnValidate()
                    begin
                        IF Rec."Price Includes VAT" = xRec."Price Includes VAT" THEN
                            EXIT;
                    end;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = Basic, Suite;
                    DecimalPlaces = 2 : 2;
                    Editable = ProfitEditable;
                    ToolTip = 'Specifies the profit margin you want to sell the item at.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = UnitCostEnable;
                    ToolTip = 'Specifies the cost per unit of the item.';

                    trigger OnDrillDown()
                    var
                        ShowAvgCalcItem: Codeunit "Show Avg. Calc. - Item";
                    begin
                        ShowAvgCalcItem.DrillDownAvgCostAdjmtPoint(Rec)
                    end;
                }
            }
            group("Financial Details")
            {
                Caption = 'Financial Details';
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the item''s general product posting group. It links business transactions made for this item with the general ledger to account for the value of trade with the item.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the Tax product posting group. Links business transactions made for this item with the general ledger, to account for Tax amounts resulting from trade with the item.';
                    Visible = UseVAT;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the tax group that is used to calculate and post sales tax.';
                    Visible = UseSalesTax;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = InventoryItemEditable;
                    Importance = Additional;
                    ShowMandatory = InventoryItemEditable;
                    ToolTip = 'Specifies the inventory posting group. Links business transactions made for the item with an inventory account in the general ledger, to group amounts for that item type.';
                }
            }
            group(Replenishment)
            {
                Caption = 'Replenishment';
                field("Replenishment System"; Rec."Replenishment System")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the type of supply order created by the planning system when the item needs to be replenished.';
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the reordering policy.';

                    trigger OnValidate()
                    begin
                        EnablePlanningControls
                    end;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ToolTip = 'Specifies the number of the production BOM.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
            }
            action("Item Journal")
            {
                Caption = 'Item Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Journal";
            }
        }
        area(reporting)
        {
            // action("Item Turnover")
            // {
            //     ApplicationArea = Basic,Suite;
            //     Caption = 'Item Turnover';
            //     Image = "Report";
            //     Promoted = false;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = "Report";
            //     RunObject = Report "Item Turnover";
            //     ToolTip = 'View a detailed account of item turnover by periods after you have set the relevant filters for location and variant.';
            // }
            action("Item Transaction Detail")
            {
                Caption = 'Item Transaction Detail';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "Item Transaction Detail";
            }
        }
        area(navigation)
        {
            group("E&ntries")
            {
                Caption = 'E&ntries';
                Image = Entries;
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = ItemLedger;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("&Phys. Inventory Ledger Entries")
                {
                    Caption = '&Phys. Inventory Ledger Entries';
                    Image = PhysicalInventoryLedger;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Phys. Inventory Ledger Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ToolTip = 'View how many units of the item you had in stock at the last physical count.';
                }
            }
            group(Availability)
            {
                Caption = 'Availability';
                Image = ItemAvailability;
                action(ItemsByLocation)
                {
                    AccessByPermission = TableData 14 = R;
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;
                    ToolTip = 'Show a list of items grouped by location.';

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Items by Location", Rec);
                    end;
                }
            }
            group("&Item Availability by")
            {
                Caption = '&Item Availability by';
                Image = ItemAvailability;
                action("<Action110>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Event';
                    Image = "Event";
                    ToolTip = 'View how the actual and projected inventory level of an item will develop over time according to supply and demand events.';

                    trigger OnAction()
                    begin
                        ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByEvent);
                    end;
                }
                action(Period)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Period';
                    Image = Period;
                    RunObject = Page "Item Availability by Periods";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Filter");
                    ToolTip = 'Show the actual and projected quantity of an item over time according to a specified time interval, such as by day, week or month.';
                }
                action(Location)
                {
                    Caption = 'Location';
                    Image = Warehouse;
                    RunObject = Page "Item Availability by Location";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Filter");
                }
            }
            // group(Statistics)
            // {
            //     Caption = 'Statistics';
            //     Image = Statistics;
            //     action(Statistics)
            //     {
            //         ApplicationArea = Basic,Suite;
            //         Caption = 'Statistics';
            //         Image = Statistics;
            //         ShortCutKey = 'F7';
            //         ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

            //         trigger OnAction()
            //         var
            //             ItemStatistics: Page "5827";
            //         begin
            //             ItemStatistics.SetItem(Rec);
            //             ItemStatistics.RUNMODAL;
            //         end;
            //     }
            //     action("Entry Statistics")
            //     {
            //         ApplicationArea = Basic,Suite;
            //         Caption = 'Entry Statistics';
            //         Image = EntryStatistics;
            //         RunObject = Page "Item Entry Statistics";
            //         RunPageLink = "No."=FIELD("No."),
            //                       "Date Filter"=FIELD("Date Filter"),
            //                       "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
            //                       "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
            //                       "Location Filter"=FIELD("Location Filter"),
            //                       "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
            //                       "Variant Filter"=FIELD("Variant Filter");
            //         ToolTip = 'View statistics for item ledger entries.';
            //     }
            // }
            group("Assembly/Production")
            {
                Caption = 'Assembly/Production';
                Image = Production;
                action(Structure)
                {
                    Caption = 'Structure';
                    Image = Hierarchy;

                    trigger OnAction()
                    var
                        BOMStructure: Page "BOM Structure";
                    begin
                        BOMStructure.InitItem(Rec);
                        BOMStructure.RUN;
                    end;
                }
                // action("Cost Shares")
                // {
                //     Caption = 'Cost Shares';
                //     Image = CostBudget;

                //     trigger OnAction()
                //     var
                //         BOMCostShares: Page "5872";
                //     begin
                //         BOMCostShares.InitItem(Rec);
                //         BOMCostShares.RUN;
                //     end;
                // }
            }
            group("Assemb&ly")
            {
                Caption = 'Assemb&ly';
                Image = AssemblyBOM;
                action("Assembly BOM")
                {
                    Caption = 'Assembly BOM';
                    Image = BOM;
                    RunObject = Page "Assembly BOM";
                    RunPageLink = "Parent Item No." = FIELD("No.");
                }
                action("Where-Used")
                {
                    Caption = 'Where-Used';
                    Image = Track;
                    RunObject = Page "Where-Used List";
                    RunPageLink = "Type" = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING(Type, "No.");
                }
                action("Calc. Stan&dard Cost")
                {
                    AccessByPermission = TableData 90 = R;
                    Caption = 'Calc. Stan&dard Cost';
                    Image = CalculateCost;

                    trigger OnAction()
                    begin
                        CLEAR(CalculateStdCost);
                        CalculateStdCost.CalcItem(Rec."No.", TRUE);
                    end;
                }
                action("Calc. Unit Price")
                {
                    AccessByPermission = TableData 90 = R;
                    Caption = 'Calc. Unit Price';
                    Image = SuggestItemPrice;

                    trigger OnAction()
                    begin
                        CLEAR(CalculateStdCost);
                        CalculateStdCost.CalcAssemblyItemPrice(Rec."No.")
                    end;
                }
            }
            group(Production)
            {
                Caption = 'Production';
                Image = Production;
                action("Production BOM")
                {
                    Caption = 'Production BOM';
                    Image = BOM;
                    RunObject = Page "Production BOM";
                    RunPageLink = "No." = FIELD("Production BOM No.");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    // CRMCouplingManagement: Codeunit "CRM Coupling Management";
    // WorkflowManagement: Codeunit "Workflow Management";
    // WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        // CreateItemFromTemplate;
        // CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
        // OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        // //ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);

        // EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode + '|' +
        //   WorkflowEventHandling.RunWorkflowOnItemChangedCode;

        // EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Item,EventFilter);

        //CurrPage.ItemAttributesFactbox.PAGE.LoadItemAttributesData("No.");
    end;

    trigger OnAfterGetRecord()
    begin
        EnableControls
    end;

    trigger OnInit()
    begin
        InitControls
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        InsertItemUnitOfMeasure;
        Rec."Item Category Code" := 'FOOD';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Item Category Code" := 'FOOD';
        OnNewRec
    end;

    trigger OnOpenPage()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled;
        EnableControls;

        GLSetup.GET;
        //  UseVAT := GLSetup."VAT in Use";
        UseSalesTax := NOT UseVAT;
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        SkilledResourceList: Page "Skilled Resource List";
        IsFoundationEnabled: Boolean;
        ShowStockoutWarningDefaultYes: Boolean;
        ShowStockoutWarningDefaultNo: Boolean;
        ShowPreventNegInventoryDefaultYes: Boolean;
        ShowPreventNegInventoryDefaultNo: Boolean;
        [InDataSet]
        TimeBucketEnable: Boolean;
        [InDataSet]
        SafetyLeadTimeEnable: Boolean;
        [InDataSet]
        SafetyStockQtyEnable: Boolean;
        [InDataSet]
        ReorderPointEnable: Boolean;
        [InDataSet]
        ReorderQtyEnable: Boolean;
        [InDataSet]
        MaximumInventoryEnable: Boolean;
        [InDataSet]
        MinimumOrderQtyEnable: Boolean;
        [InDataSet]
        MaximumOrderQtyEnable: Boolean;
        [InDataSet]
        OrderMultipleEnable: Boolean;
        [InDataSet]
        IncludeInventoryEnable: Boolean;
        [InDataSet]
        ReschedulingPeriodEnable: Boolean;
        [InDataSet]
        LotAccumulationPeriodEnable: Boolean;
        [InDataSet]
        DampenerPeriodEnable: Boolean;
        [InDataSet]
        DampenerQtyEnable: Boolean;
        [InDataSet]
        OverflowLevelEnable: Boolean;
        [InDataSet]
        StandardCostEnable: Boolean;
        [InDataSet]
        UnitCostEnable: Boolean;
        [InDataSet]
        SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        [InDataSet]
        InventoryItemEditable: Boolean;
        [InDataSet]
        UnitCostEditable: Boolean;
        ProfitEditable: Boolean;
        PriceEditable: Boolean;
        UseSalesTax: Boolean;
        UseVAT: Boolean;
        SpecialPricesAndDiscountsTxt: Text;
        CreateNewTxt: Label 'Create New...';
        ViewOrChangeExistingTxt: Label 'View or Change Existing...';
        CreateNewSpecialPriceTxt: Label 'Create New Special Price...';
        CreateNewSpecialDiscountTxt: Label 'Create New Special Discount...';
        EnabledApprovalWorkflowsExist: Boolean;
        EventFilter: Text;
        NoFieldVisible: Boolean;
        NewMode: Boolean;

    local procedure EnableControls()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        DocumentNoVisibility: Codeunit "DocumentNoVisibility";
    begin
        InventoryItemEditable := Rec.Type = Rec.Type::Inventory;

        IF Rec.Type = Rec.Type::Inventory THEN BEGIN
            ItemLedgerEntry.SETRANGE("Item No.", Rec."No.");
            UnitCostEditable := ItemLedgerEntry.ISEMPTY;
        END ELSE
            UnitCostEditable := TRUE;

        ProfitEditable := Rec."Price/Profit Calculation" <> Rec."Price/Profit Calculation"::"Profit=Price-Cost";
        PriceEditable := Rec."Price/Profit Calculation" <> Rec."Price/Profit Calculation"::"Price=Cost+Profit";

        EnablePlanningControls;
        EnableCostingControls;

        EnableShowStockOutWarning;

        SetSocialListeningFactboxVisibility;
        NoFieldVisible := DocumentNoVisibility.ItemNoIsVisible;
        EnableShowShowEnforcePositivInventory;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;

        UpdateSpecialPricesAndDiscountsTxt;
    end;

    local procedure OnNewRec()
    var
        DocumentNoVisibility: Codeunit "DocumentNoVisibility";
    begin
        IF GUIALLOWED THEN BEGIN
            EnableControls;
            IF Rec."No." = '' THEN
                IF DocumentNoVisibility.ItemNoSeriesIsDefault THEN
                    NewMode := TRUE;
        END;
    end;

    local procedure EnableShowStockOutWarning()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.GET;
        ShowStockoutWarningDefaultYes := SalesSetup."Stockout Warning";
        ShowStockoutWarningDefaultNo := NOT ShowStockoutWarningDefaultYes;

        EnableShowShowEnforcePositivInventory
    end;

    local procedure InsertItemUnitOfMeasure()
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        IF Rec."Base Unit of Measure" <> '' THEN BEGIN
            ItemUnitOfMeasure.INIT;
            ItemUnitOfMeasure."Item No." := Rec."No.";
            ItemUnitOfMeasure.VALIDATE(Code, Rec."Base Unit of Measure");
            ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
            ItemUnitOfMeasure.INSERT;
        END;
    end;

    local procedure EnableShowShowEnforcePositivInventory()
    var
        InventorySetup: Record "Inventory Setup";
    begin
        InventorySetup.GET;
        ShowPreventNegInventoryDefaultYes := InventorySetup."Prevent Negative Inventory";
        ShowPreventNegInventoryDefaultNo := NOT ShowPreventNegInventoryDefaultYes;
    end;

    local procedure EnablePlanningControls()
    var
        PlanningGetParam: Codeunit "Planning-Get Parameters";
        TimeBucketEnabled: Boolean;
        SafetyLeadTimeEnabled: Boolean;
        SafetyStockQtyEnabled: Boolean;
        ReorderPointEnabled: Boolean;
        ReorderQtyEnabled: Boolean;
        MaximumInventoryEnabled: Boolean;
        MinimumOrderQtyEnabled: Boolean;
        MaximumOrderQtyEnabled: Boolean;
        OrderMultipleEnabled: Boolean;
        IncludeInventoryEnabled: Boolean;
        ReschedulingPeriodEnabled: Boolean;
        LotAccumulationPeriodEnabled: Boolean;
        DampenerPeriodEnabled: Boolean;
        DampenerQtyEnabled: Boolean;
        OverflowLevelEnabled: Boolean;
    begin
        // PlanningGetParam.SetPlanningParameters(Rec."Reordering Policy", Rec."Include Inventory",
        //   TimeBucketEnabled, SafetyLeadTimeEnabled, SafetyStockQtyEnabled,
        //   ReorderPointEnabled, ReorderQtyEnabled, MaximumInventoryEnabled,
        //   MinimumOrderQtyEnabled, MaximumOrderQtyEnabled, OrderMultipleEnabled, IncludeInventoryEnabled,
        //   ReschedulingPeriodEnabled, LotAccumulationPeriodEnabled,
        //   DampenerPeriodEnabled, DampenerQtyEnabled, OverflowLevelEnabled);

        // TimeBucketEnable := TimeBucketEnabled;
        // SafetyLeadTimeEnable := SafetyLeadTimeEnabled;
        // SafetyStockQtyEnable := SafetyStockQtyEnabled;
        // ReorderPointEnable := ReorderPointEnabled;
        // ReorderQtyEnable := ReorderQtyEnabled;
        // MaximumInventoryEnable := MaximumInventoryEnabled;
        // MinimumOrderQtyEnable := MinimumOrderQtyEnabled;
        // MaximumOrderQtyEnable := MaximumOrderQtyEnabled;
        // OrderMultipleEnable := OrderMultipleEnabled;
        // IncludeInventoryEnable := IncludeInventoryEnabled;
        // ReschedulingPeriodEnable := ReschedulingPeriodEnabled;
        // LotAccumulationPeriodEnable := LotAccumulationPeriodEnabled;
        // DampenerPeriodEnable := DampenerPeriodEnabled;
        // DampenerQtyEnable := DampenerQtyEnabled;
        // OverflowLevelEnable := OverflowLevelEnabled;
    end;

    local procedure EnableCostingControls()
    begin
        StandardCostEnable := Rec."Costing Method" = Rec."Costing Method"::Standard;
        UnitCostEnable := Rec."Costing Method" <> Rec."Costing Method"::Standard;
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
    //SocialListeningMgt: Codeunit "Social Listening Management";
    begin
        //SocialListeningMgt.GetItemFactboxVisibility(Rec, SocialListeningSetupVisible, SocialListeningVisible);
    end;

    local procedure InitControls()
    begin
        UnitCostEnable := TRUE;
        StandardCostEnable := TRUE;
        OverflowLevelEnable := TRUE;
        DampenerQtyEnable := TRUE;
        DampenerPeriodEnable := TRUE;
        LotAccumulationPeriodEnable := TRUE;
        ReschedulingPeriodEnable := TRUE;
        IncludeInventoryEnable := TRUE;
        OrderMultipleEnable := TRUE;
        MaximumOrderQtyEnable := TRUE;
        MinimumOrderQtyEnable := TRUE;
        MaximumInventoryEnable := TRUE;
        ReorderQtyEnable := TRUE;
        ReorderPointEnable := TRUE;
        SafetyStockQtyEnable := TRUE;
        SafetyLeadTimeEnable := TRUE;
        TimeBucketEnable := TRUE;

        InventoryItemEditable := Rec.Type = Rec.Type::Inventory;
        Rec."Costing Method" := Rec."Costing Method"::FIFO;
        UnitCostEditable := TRUE;
    end;

    local procedure UpdateSpecialPricesAndDiscountsTxt()
    var
        TempSalesPriceAndLineDiscBuff: Record "Sales Price and Line Disc Buff" temporary;
    begin
        SpecialPricesAndDiscountsTxt := CreateNewTxt;
        TempSalesPriceAndLineDiscBuff.LoadDataForItem(Rec);
        IF NOT TempSalesPriceAndLineDiscBuff.ISEMPTY THEN
            SpecialPricesAndDiscountsTxt := ViewOrChangeExistingTxt;
    end;

    local procedure CreateItemFromTemplate()
    var
        ItemTemplate: Record "Item Templ.";
        Item: Record "Item";
    begin
        // IF NewMode THEN BEGIN
        //     IF ItemTemplate.Get(Item."NO") THEN BEGIN
        //         Rec.COPY(Item);
        //         CurrPage.UPDATE;
        //     END;

        //     // Enforce FIFO costing method for Foundation
        //     IF ApplicationAreaSetup.IsFoundationEnabled THEN
        //         Item.VALIDATE("Costing Method", Rec."Costing Method"::FIFO);

        //     NewMode := FALSE;
        // END;
    end;
}

