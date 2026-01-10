from flask import Flask, request, render_template_string

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    table_html = ''
    number = None
    if request.method == 'POST':
        try:
            number = int(request.form.get('number'))
            table_html = f'<h3>Multiplication Table for {number}</h3><ul>'
            for i in range(1, 11):
                table_html += f'<li>{number} x {i} = {number * i}</li>'
            table_html += '</ul>'
        except (ValueError, TypeError):
            table_html = '<p style="color:red;">Please enter a valid integer.</p>'

    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Multiplication Table Generator</title>
        <style>
            body {{ font-family: sans-serif; max-width: 600px; margin: 2rem auto; padding: 0 1rem; }}
            input, button {{ padding: 0.5rem; font-size: 1rem; }}
            ul {{ list-style-type: none; padding: 0; }}
            li {{ padding: 5px 0; border-bottom: 1px solid #eee; }}
        </style>
    </head>
    <body>
        <h1>Enter a number to see its table</h1>
        <form method="post">
            <input type="number" name="number" required placeholder="Enter a number" value="{number if number is not None else ''}">
            <button type="submit">Generate Table</button>
        </form>
        <hr>
        {table_html}
    </body>
    </html>
    '''
    return render_template_string(html)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
