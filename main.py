import sqlite3
from flask import Flask, abort, jsonify

app = Flask(__name__)


def get_record_by_id(record_id):
    con = sqlite3.connect("animal.db")
    cur = con.cursor()
    sql = f"""SELECT r.name, r.animal_id, b.breeds, r.age_upon_outcome
               FROM results r 
               LEFT JOIN animals_breeds b ON b.id = r.breed
               where animal_id = '{record_id}'
    """
    result = cur.execute(sql).fetchall()
    if result:
        return {
            "name": result[0][0],
            "animal_id": result[0][1],
            "breeds": result[0][2],
            "age_upon_outcome": result[0][3]
        }


@app.route('/<record_id>')
def index(record_id):
    result = get_record_by_id(record_id)
    if not result:
        abort(404)
    return jsonify(result)


if __name__ == '__main__':
    app.run(port=5002)
