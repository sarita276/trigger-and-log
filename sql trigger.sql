use employee;
-- insert
DELIMITER $$

CREATE TRIGGER trg_employees_insert
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO Employees_Audit (EmployeeID, ActionType, NewName, NewPosition, NewSalary)
    VALUES (NEW.EmployeeID, 'INSERT', NEW.Name, NEW.Position, NEW.Salary);
END$$

DELIMITER ;

-- update
DELIMITER $$

CREATE TRIGGER trg_employees_update
AFTER UPDATE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO Employees_Audit (EmployeeID, ActionType,
                                 OldName, OldPosition, OldSalary,
                                 NewName, NewPosition, NewSalary)
    VALUES (NEW.EmployeeID, 'UPDATE',
            OLD.Name, OLD.Position, OLD.Salary,
            NEW.Name, NEW.Position, NEW.Salary);
END$$

DELIMITER ;

-- delete
DELIMITER $$

CREATE TRIGGER trg_employees_delete
AFTER DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO Employees_Audit (EmployeeID, ActionType,
                                 OldName, OldPosition, OldSalary)
    VALUES (OLD.EmployeeID, 'DELETE',
            OLD.Name, OLD.Position, OLD.Salary);
END$$

DELIMITER ;