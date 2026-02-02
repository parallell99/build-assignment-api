import express from "express";
import connectionPool from "./utils/db.mjs";
const app = express();
const port = 4001;

app.use(express.json());

app.get("/test", (req, res) => {
  return res.json("Server API is working 🚀");
});



app.get("/assignments", async (req, res) => {
  try{
    const result = await connectionPool.query("SELECT * FROM assignments");
    return res.json(result.rows);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

app.post("/assignments", async (req, res) => {
  try{
    const assignmentdata = {...req.body,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
      published_at: new Date().toISOString(),
    }
    const result = await connectionPool.query(
      `INSERT INTO assignments (user_id,title, content, category, length, status, created_at, updated_at, published_at) 
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *`, 
      
      [
        1,
        assignmentdata.title, 
        assignmentdata.content, 
        assignmentdata.category, 
        assignmentdata.length, 
        assignmentdata.status, 
        assignmentdata.created_at, 
        assignmentdata.updated_at, 
        assignmentdata.published_at
      ]);
    return res.json(result.rows[0]);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

app.get("/assignments/:assignmentId", async (req, res) => {
  try{
    const { assignmentId } = req.params;
    const result = await connectionPool.query("SELECT * FROM assignments WHERE assignment_id = $1", [assignmentId]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Assignment not found" });
    }
    
    return res.json(result.rows[0]);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

app.put("/assignments/:assignmentId", async (req, res) => {
  try {
    const { assignmentId } = req.params;
    const { title, content, category, length, status } = req.body;
    
    // ตรวจสอบว่ามี assignment นี้หรือไม่
    const checkResult = await connectionPool.query(
      "SELECT * FROM assignments WHERE assignment_id = $1",
      [assignmentId]
    );
    
    if (checkResult.rows.length === 0) {
      return res.status(404).json({ error: "Assignment not found" });
    }
    
    // อัปเดตข้อมูล
    const result = await connectionPool.query(
      `UPDATE assignments 
       SET title = COALESCE($1, title),
           content = COALESCE($2, content),
           category = COALESCE($3, category),
           length = COALESCE($4, length),
           status = COALESCE($5, status),
           updated_at = CURRENT_TIMESTAMP
       WHERE assignment_id = $6
       RETURNING *`,
      [title, content, category, length, status, assignmentId]
    );
    
    return res.json({
      message: "Assignment updated successfully",
      data: result.rows[0]
    });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});


app.delete("/assignments/:assignmentId", async (req, res) => {
  try {
    const { assignmentId } = req.params;
    
    // ตรวจสอบว่ามี assignment นี้หรือไม่
    const checkResult = await connectionPool.query(
      "SELECT * FROM assignments WHERE assignment_id = $1",
      [assignmentId]
    );
    
    if (checkResult.rows.length === 0) {
      return res.status(404).json({ error: "Assignment not found" });
    }
    
    // ลบข้อมูล
    await connectionPool.query(
      "DELETE FROM assignments WHERE assignment_id = $1",
      [assignmentId]
    );
    
    return res.json({ message: "Assignment deleted successfully" });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server is running at ${port}`);
});
