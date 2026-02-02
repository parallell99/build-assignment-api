-- ========== ข้อมูลทดสอบ (Test / Seed Data) ==========
-- assignments มี FK ไปที่ users(user_id) ดังนั้นต้องมี user_id 1–5 ในตาราง users ก่อน
-- ถ้ายังไม่มีตาราง users หรือยังไม่มีข้อมูล ให้รันส่วนนี้ก่อน (หรือข้ามถ้ามีแล้ว)

CREATE TABLE IF NOT EXISTS users (
  user_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email)
SELECT * FROM (VALUES
  ('john_doe', 'john.doe@example.com'),
  ('jane_smith', 'jane.smith@example.com'),
  ('bob_wilson', 'bob.wilson@example.com'),
  ('alice_brown', 'alice.brown@example.com'),
  ('charlie_davis', 'charlie.davis@example.com')
) AS v(username, email)
WHERE NOT EXISTS (SELECT 1 FROM users LIMIT 1);

-- เติมข้อมูลปลอมลงตาราง assignments
INSERT INTO assignments (title, content, category, length, user_id, status, published_at)
VALUES
  (
    'SQL Select Basics',
    'Practice SELECT queries with filters.',
    'backend',
    '20 min',
    1,
    'draft',
    NULL
  ),
  (
    'Introduction to JavaScript',
    'Complete the following: 1) Factorial function. 2) Reverse a string. 3) Simple calculator.',
    'homework',
    'medium',
    1,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '5 days'
  ),
  (
    'React TodoList Component',
    'Build a TodoList: Add todos, Mark complete, Delete, Filter by status.',
    'project',
    'long',
    2,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '3 days'
  ),
  (
    'Database Design Quiz',
    'Answer: 1) What is normalization? 2) Primary vs foreign key. 3) ACID properties.',
    'quiz',
    'short',
    1,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
  ),
  (
    'API Integration Task',
    'Create REST API that fetches user data from external service and stores in DB.',
    'project',
    'medium',
    3,
    'draft',
    NULL
  ),
  (
    'CSS Layout Exercise',
    'Responsive layout using Flexbox and Grid for mobile, tablet, desktop.',
    'homework',
    'short',
    2,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
  ),
  (
    'Final Exam Preparation',
    'Review: JavaScript, React hooks, Node.js, database queries.',
    'exam',
    'long',
    4,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '7 days'
  ),
  (
    'Git Workflow Assignment',
    'Feature branch, commit with proper messages, create pull request.',
    'homework',
    'short',
    5,
    'draft',
    NULL
  ),
  (
    'Authentication System',
    'JWT: login, logout, protected routes.',
    'project',
    'long',
    3,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '4 days'
  ),
  (
    'Unit Testing Practice',
    'Unit tests for calculator: add, subtract, multiply, divide, error handling.',
    'homework',
    'medium',
    1,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '6 days'
  ),
  (
    'Data Visualization',
    'Charts with Chart.js or D3.js: sales data for past 12 months.',
    'project',
    'medium',
    4,
    'archived',
    CURRENT_TIMESTAMP - INTERVAL '30 days'
  ),
  (
    'TypeScript Basics',
    'Convert JavaScript to TypeScript: type annotations, interfaces, type safety.',
    'homework',
    'short',
    2,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
  ),
  (
    'REST API Design',
    'Design endpoints for CRUD: list, get by id, create, update, delete. Include validation.',
    'project',
    'long',
    1,
    'draft',
    NULL
  ),
  (
    'SQL Practice Quiz',
    'Write queries: SELECT with WHERE, JOIN, GROUP BY, ORDER BY, LIMIT.',
    'quiz',
    'short',
    3,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '3 days'
  ),
  (
    'Deployment Guide',
    'Document: deploy Node.js app, env vars, DB setup, CI/CD.',
    'project',
    'long',
    5,
    'archived',
    CURRENT_TIMESTAMP - INTERVAL '14 days'
  ),
  (
    'Frontend Form Validation',
    'Form with required fields, email format, min/max length. Show error messages.',
    'homework',
    'medium',
    4,
    'published',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
  );
