for k in ["data", "science", "parallel", "computer", "hadoop", "reduce"]:
    s = sum(ord(c) for c in k)
    print(k, s, f"R{s % 2}")